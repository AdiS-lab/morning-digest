#!/bin/bash
# Morning Wire — Daily Digest Generator
# Run manually: bash scripts/generate-digest.sh
# Or schedule with GitHub Actions at 8:00 AM EST

PROJECT_DIR="C:/01-Projects/RealProjects/morning-digest"
DIGEST_DIR="$PROJECT_DIR/digests"
GUIDELINES_DIR="$PROJECT_DIR/guidelines"
TODAY=$(date +%Y-%m-%d)
TODAY_DISPLAY=$(date +"%B %-d, %Y")

# Load API key from .env if not already set
if [ -z "$ANTHROPIC_API_KEY" ] && [ -f "$PROJECT_DIR/.env" ]; then
  export $(grep -v '^#' "$PROJECT_DIR/.env" | xargs)
fi

cd "$PROJECT_DIR"

claude --print -p "
You are generating today's Morning Wire daily news digest. Today is ${TODAY_DISPLAY}.

IMPORTANT: Read these files first for your instructions:
- ${GUIDELINES_DIR}/digest-guidelines.md
- ${GUIDELINES_DIR}/diagram-guidelines.md

Then do the following:

1. Search for today's top news. Use multiple searches: 'top news today ${TODAY_DISPLAY}', 'world news today', 'technology news today ${TODAY}'. Get at least 3 searches worth of stories.

2. Create the daily digest at ${DIGEST_DIR}/${TODAY}.html following the digest guidelines exactly. Raw HTML, no CSS, default fonts, purple links. H1 is the date. Each story: H2, 1-2 paragraphs, 'more' link. 'Everything else' section at the bottom. Previous day link, home link.

3. Create 'more' pages for the top 4-5 stories in ${DIGEST_DIR}/. EVERY more page MUST have at least one rough.js diagram (bar chart, timeline, line chart, comparison, etc). Follow the diagram guidelines exactly. Each more page gets: back to digest link, home link, one external source link at the bottom.

4. Update ${DIGEST_DIR}/index.html to add today's date to the archive links at the bottom.

5. Make sure all links work. All files are in the same digests/ folder. Links are flat: href='filename.html'. home links to index.html, back links to ${TODAY}.html, previous/next day navigation between digests.

6. After writing all files, open the digest: start '' '${DIGEST_DIR}/${TODAY}.html'

Do NOT skip diagrams. They are the entire point. Every more page needs at least one.
Short sentences. No em dashes. No CSS. Default browser everything.
" --allowedTools "WebSearch,Read,Write,Edit,Bash,Glob"
