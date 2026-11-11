# Generation Instructions

Read before generating anything:
- guidelines/digest-guidelines.md
- guidelines/diagram-guidelines.md
- digests/manifest.json

## Folder structure

Daily digest: `digests/{MONTH}/{TODAY}.html`
Story pages: `digests/{MONTH}/{TODAY}/<slug>.html`
Static pages stay in `digests/` root.

## Link rules

From a digest page:
- home: `../index.html`
- story: `{TODAY}/<slug>.html`

From a story page:
- home: `../../index.html`
- back to digest: `../{TODAY}.html`
- cross-link to other date: `../<other-date>/<slug>.html`

Previous day: use the most recent date in manifest.json.

## Steps

1. Search for today's top news. Two searches minimum.
2. Create digest page. Raw HTML, no CSS. H1 is the date. Each story: H2, 1-2 paragraphs, "more" link. Previous day link (from manifest). No "next day" link on the latest digest. Home link.
3. Create story pages for top 4-5 stories. Each page needs real substance: 4-6 paragraphs across 2-3 sections covering the key facts, background, and what happens next. Every story page must have at least one rough.js diagram, but it must earn its place. Vary the diagram types across pages. Do NOT use the same type on every page. Back to digest link. Home link. One external source link at bottom.
4. Update `digests/index.html`: change "today" link, add date to archive.
5. Update `digests/manifest.json`: append digest entry with date, file, summary, stories (headline, file, tags). Reuse existing tags for consistency.
6. Check manifest for related stories by tag. Add cross-links.

## Style

Short sentences. No em dashes. No CSS. Default browser everything. Use **bold** for key phrases to make pages scannable.
