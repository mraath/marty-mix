#!/bin/bash
# Graphify semantic extraction with OpenRouter free VISION model fallback
# Checks for ACTUAL progress (new cached chunks), not just exit code

unset PYTHONPATH
source ~/.hermes/.env

REPO="/c/Projects/marty-mix"
CACHE_DIR="$REPO/graphify-out/cache/semantic"
cd "$REPO" || exit 1

# Free models that support image input, ordered best → worst
MODELS=(
  "google/gemma-4-31b-it:free"
  "google/gemma-4-26b-a4b-it:free"
  "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free"
  "nvidia/nemotron-nano-12b-v2-vl:free"
  "nvidia/nemotron-3.5-content-safety:free"
)

OPENROUTER_URL="https://openrouter.ai/api/v1"
CHUNKS_NEEDED=132  # Total chunks to process

for MODEL in "${MODELS[@]}"; do
  BEFORE=$(ls "$CACHE_DIR" 2>/dev/null | wc -l)
  
  echo "=========================================="
  echo "Trying: $MODEL (cache before: $BEFORE)"
  echo "=========================================="
  
  OUTPUT=$(OPENAI_BASE_URL="$OPENROUTER_URL" \
  OPENAI_API_KEY="$OPENROUTER_API_KEY" \
  OPENAI_MODEL="$MODEL" \
  graphify extract . --backend openai 2>&1)
  
  echo "$OUTPUT"
  
  AFTER=$(ls "$CACHE_DIR" 2>/dev/null | wc -l)
  NEW=$((AFTER - BEFORE))
  
  echo ""
  echo "Cache: $BEFORE → $AFTER (+$NEW chunks)"
  
  # Check for "all semantic chunks failed" in output
  if echo "$OUTPUT" | grep -q "all semantic chunks failed"; then
    echo "⚠️  All chunks failed with $MODEL"
  elif [ $NEW -gt 0 ]; then
    echo "✅ Made progress with $MODEL (+$NEW chunks)"
    if [ $AFTER -ge $((CHUNKS_NEEDED + 91)) ]; then
      echo "🎉 All chunks processed! Done."
      exit 0
    fi
  else
    echo "⚠️  No new chunks processed"
  fi
  
  echo ""
done

echo "❌ All free models tried. Check cache at: $CACHE_DIR"
echo "   Total cached: $(ls "$CACHE_DIR" 2>/dev/null | wc -l)"
exit 1
