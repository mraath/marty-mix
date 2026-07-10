#!/bin/bash
# Rotate through Gemini free tier, keep graphify running.
# Each key has 5 RPM and a daily quota. We'll process chunks until we hit a rate limit, then switch.
set -e
cd /c/Projects/marty-mix
source ~/.hermes/.env

KEYS=("$GEMINI_API_KEY" "$GEMINI_API_KEY_AU" "$GOOGLE_API_KEY")
KEY_NAMES=("GEMINI_API_KEY" "GEMINI_API_KEY_AU" "GOOGLE_API_KEY")

# How long to wait between key switches (in seconds) to allow rate limit to recover
WAIT_BETWEEN_KEYS=60
# Maximum number of full rotations before giving up (each rotation tries all 3 keys)
MAX_ROTATIONS=30

round=0
while [ $round -lt $MAX_ROTATIONS ]; do
    echo "=== Starting rotation round $((round+1)) ==="
    for i in "${!KEYS[@]}"; do
        key="${KEYS[$i]}"
        key_name="${KEY_NAMES[$i]}"
        echo "--- Using $key_name (${key:0:8}...) ---"
        
        # Run graphify with current key, let it process until it hits a chunk
        OPENAI_BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai/" \
        OPENAI_API_KEY="$key" \
        OPENAI_MODEL="gemini-2.0-flash" \
        /c/Users/MarthinusR/AppData/Local/hermes/hermes-agent/venv/Scripts/graphify extract . --backend openai --max-concurrency 1 --api-timeout 120 2>&1
        
        exit_code=${PIPESTATUS[0]}
        echo "[$key_name] graphify finished with exit code $exit_code"
        
        # Check cache size
        cached=$(ls graphify-out/cache/semantic/*.json 2>/dev/null | wc -l)
        echo "Cached semantic chunks: $cached"
        
        # If exit code is 0, we're done
        if [ $exit_code -eq 0 ]; then
            echo "=== SUCCESS: All chunks processed! ==="
            exit 0
        fi
        
        # If we got a 429, we wait a bit before trying the next key
        # (The graphify command already waited internally if it got a retry-delay, but we add extra)
        echo "Waiting $WAIT_BETWEEN_KEYS seconds before trying next key..."
        sleep $WAIT_BETWEEN_KEYS
    done
    round=$((round+1))
    echo "=== Completed rotation round $round ==="
    echo ""
done

echo "=== Max rotations reached. Check progress and consider increasing wait time or trying again later. ==="