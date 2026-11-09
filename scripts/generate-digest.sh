#!/bin/bash
# Morning Wire — Daily Digest Generator
# Runs on login via Windows Task Scheduler.
# Catches up on any missed days since the last digest.

PROJECT_DIR="C:/01-Projects/RealProjects/morning-digest"
export PATH="$PATH:$HOME/.local/bin:$HOME/AppData/Local/Microsoft/WinGet/Packages/Anthropic.ClaudeCode_Microsoft.Winget.Source_8wekyb3d8bbwe"
cd "$PROJECT_DIR"

# Find the last digest date from manifest
LAST_DATE=$(grep -o '"date": "[0-9-]*"' digests/manifest.json | tail -1 | grep -o '[0-9-]*')
TODAY=$(date +%Y-%m-%d)

if [ "$LAST_DATE" = "$TODAY" ]; then
  echo "Already up to date."
  exit 0
fi

# Build list of missing dates (from day after last digest through today)
MISSING=()
CURRENT=$(date -d "$LAST_DATE + 1 day" +%Y-%m-%d)
while [ "$CURRENT" != "$(date -d "$TODAY + 1 day" +%Y-%m-%d)" ]; do
  MISSING+=("$CURRENT")
  CURRENT=$(date -d "$CURRENT + 1 day" +%Y-%m-%d)
done

echo "Last digest: $LAST_DATE"
echo "Missing dates: ${MISSING[*]}"
echo "Generating..."

for DAY in "${MISSING[@]}"; do
  DAY_DISPLAY=$(date -d "$DAY" +"%B %-d, %Y")
  MONTH=$(date -d "$DAY" +%Y-%m)

  echo "--- Generating $DAY ---"

  # Step 1: Search + digest + manifest (haiku)
  claude --print --model haiku -p "
  Today is ${DAY_DISPLAY}. MONTH=${MONTH}. TODAY=${DAY}.
  Read guidelines/generation-instructions.md, then do steps 1-2 and 4-6.
  Create the digest page and update index/manifest.
  Do NOT create story pages yet.
  " --allowedTools "WebSearch,Read,Write,Edit,Bash,Glob"

  # Step 2: Story pages with diagrams (sonnet)
  claude --print --model sonnet -p "
  Read guidelines/generation-instructions.md and guidelines/diagram-guidelines.md.
  Read the digest at digests/${MONTH}/${DAY}.html.
  Do step 3 only: create story pages in digests/${MONTH}/${DAY}/ for every story linked from the digest.
  Every page MUST have at least one rough.js diagram. Follow diagram guidelines exactly.
  Check digests/manifest.json for cross-links by tag.
  " --allowedTools "Read,Write,Edit,Bash,Glob"

  echo "--- Done $DAY ---"
done

# Push to GitHub
git add digests/
git diff --staged --quiet || git commit -m "digest: ${MISSING[*]}"
git push

# Open today's digest (after everything is done)
MONTH=$(date +%Y-%m)
cmd.exe /c start "" "$PROJECT_DIR/digests/$MONTH/$TODAY.html"

echo "All done."
