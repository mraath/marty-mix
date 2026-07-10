#!/bin/bash
# Gemini free-tier key rotation for graphify extract
# Each key has 5 RPM quota. Rotate through 3 keys to maximize throughput.
# Graphify caches results, so already-processed chunks are skipped on restart.

set -e
cd /c/Projects/marty-mix
source ~/.hermes/.env

KEYS=("$GEMINI_API_KEY" "$GEMINI_API_KEY_AU" "$GOOGLE_API_KEY")
CHUNKS_PER_WINDOW=6  # Process ~6 chunks per key (under 5 RPM with buffer)
WAIT_BETWEEN=65      # Wait 65s between key switches for rate limit reset

TOTAL_ROUNDS=0
MAX_ROUNDS=20  # Safety limit

while [ $TOTAL_ROUNDS -lt $MAX_ROUNDS ]; do
    for i in "${!KEYS[@]}"; do
        KEY="${KEYS[$i]}"
        KEY_SHORT="${KEY:0:8}..."
        
        echo ""
        echo "=== Round $((TOTAL_ROUNDS + 1)), Key $((i+1)): $KEY_SHORT ==="
        echo "$(date '+%H:%M:%S') Starting extraction with key $((i+1))..."
        
        # Run graphify with this key, let it process as many cached-miss chunks as possible
        # Concurrency 1, timeout 900s per chunk
        OPENAI_BASE_URL="https://generativelanguage.googleapis.com/v1beta/openai/" \
        OPENAI_API_KEY="$KEY" \
        OPENAI_MODEL="gemini-2.0-flash" \
        graphify extract . --backend openai --max-concurrency 1 --api-timeout 900 2>&1 | head -30
        
        EXIT_CODE=${PIPESTATUS[0]}
        echo "$(date '+%H:%M:%S') Key $((i+1)) finished (exit=$EXIT_CODE)"
        
        # Check if all chunks are done (no more misses)
        CACHE_INFO=$(ls graphify-out/cache/semantic/*.json 2>/dev/null | wc -l)
        echo "Semantic cache: $CACHE_INFO chunks cached"
        
        # If exit code is 0, extraction is complete
        if [ $EXIT_CODE -eq 0 ]; then
            echo "=== EXTRACTION COMPLETE ==="
            exit 0
        fi
        
        echo "Waiting ${WAIT_BETWEEN}s for rate limit reset..."
        sleep $WAIT_BETWEEN
    done
    
    TOTAL_ROUNDS=$((TOTAL_ROUNDS + 1))
    echo ""
    echo "=== Completed round $TOTAL_ROUNDS of key rotation ==="
done

echo "=== Max rounds reached. Check progress and rerun if needed. ==="