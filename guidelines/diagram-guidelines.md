# Diagram Guidelines

## Why diagrams

Diagrams are the core value of this format. A bar chart comparing $350B to $90B lands in one second. A paragraph explaining the same thing takes 30 seconds and doesn't stick. Every "more" page should have at least one diagram. Err on the side of MORE diagrams, not fewer.

## Library

Rough.js. Always. The hand-drawn quality makes diagrams feel human and frictionless. It removes the sterile "infographic" feel that makes people glaze over.

```html
<script src="https://unpkg.com/roughjs@4.6.6/bundled/rough.js"></script>
```

```js
const rc = rough.canvas(canvas);
```

## Beyond news

Diagrams are not limited to news. They work for any topic where data or concepts need to land fast. Math explainers, technical walkthroughs, history. The same diagram types apply. Timelines, bar charts, and line charts are the most versatile. They work for almost anything.

## The most impactful types (in order)

1. **Timelines** — Immensely helpful. Put events in spatial context. A 150-year gap on a timeline hits harder than the words "first time since 1876."
2. **Bar charts** (horizontal and vertical) — Instant comparison. $350B vs $90B. 21M bbl/day vs 5M. No reading required.
3. **Line charts** — Show trends. Unemployment flat at 4%. Aid dropping to zero. The shape tells the story.
4. **Seat maps / grids** — Composition at a glance. Senate seats, court justices.
5. **Waveform / signal plots** — For math and engineering content. Show what a function looks like.
6. **Workflow diagrams** — Boxes and arrows. Show a process.
7. **Tables** — Structured data. Use when the comparison is across multiple dimensions.

## Diagram types that work

### Horizontal bar chart
Best for: comparing named things (countries, companies, categories).
```
rc.rectangle(x, y, barW, barH, {
  fill: 'rgba(0,0,0,0.55)', fillStyle: 'solid',
  stroke: '#333', strokeWidth: 1, roughness: 1,
});
```
- Labels on the left (right-aligned), values on the right of the bar.
- Highlight the focal bar with darker fill or thicker stroke.
- One caption line below.
- Examples: oil chokepoints, protest sizes, market drops, senate flips by years.

### Vertical bar chart
Best for: time series with few data points, or comparing 2-3 quantities.
- Labels below each bar. Values above.
- Highlight the current/focal bar darker.
- Examples: ACA premiums by year, spending comparison (defense vs education).

### Line chart
Best for: trends over time with many data points.
- Draw with rough.js line segments between points.
- Dot at the current/final value.
- Dashed lines for projections or drops.
- Light grid lines at intervals (very low opacity).
- Examples: unemployment rate, Israel aid over time, loss curve, AI spending vs stock prices.

### Timeline
Best for: sequence of events.
- Horizontal line, dots at events, labels alternating above and below.
- Bold the date, regular weight for the description.
- Darken the current/focal dot.
- Examples: Ukraine war timeline, floppy disk history, cabinet impeachment history.

### Seat map / grid
Best for: showing composition of a body (senate, court, etc.).
- Grid of small rectangles, colored by category.
- Legend below.
- Highlight special items (flips, focus items) with thicker stroke.
- Examples: senate seats by party, supreme court by lean.

### Table (rough.js)
Best for: structured data with names and categories.
- Rows drawn with text, header line drawn with rough.js.
- Highlight focal row with a light background rectangle.
- Examples: midterm investigation pattern (year, president, result, investigation).

## Style rules

- Canvas width: 500-700px. Never wider than that.
- `style="display:block; margin: 20px 0;"` on every canvas.
- Colors: black/dark gray only. No color coding unless it's meaningful (party affiliation: blue/red).
- Roughness: 0.5-1.2 for most elements. Higher (1.5+) looks too messy.
- Fill style: always `'solid'`. The sketchy outline is enough texture.
- Text: `ctx.font = '11px serif'` for labels, `'12px serif'` for values, `'bold 11px serif'` for headers.
- Fill color for text: `'#333'`, not pure black. Softer.
- Axis lines: `stroke: '#333', roughness: 0.5-0.6`.
- Grid lines: `stroke: 'rgba(0,0,0,0.06)', roughness: 0.3`. Barely visible.
- Highlight the focal element. Darker fill, thicker stroke, or bold label. One thing should stand out.

## One idea per diagram

Don't cram two stories into one chart. If you need to show two things, make two canvases. Each diagram should answer one question:
- "How big was the drop?" → bar chart
- "What's the trend?" → line chart
- "When did things happen?" → timeline
- "Who's on which side?" → seat map
- "How does X compare to Y?" → comparison bars

## Common patterns

### Axes
```js
rc.line(pad.left, pad.top, pad.left, H - pad.bottom, { stroke: '#333', roughness: 0.5 });
rc.line(pad.left, H - pad.bottom, W - pad.right, H - pad.bottom, { stroke: '#333', roughness: 0.5 });
```

### Padding object
```js
const pad = { top: 20, right: 20, bottom: 40, left: 50 };
// Adjust left for label width. Horizontal bars need more (100-160).
```

### Focal highlight
```js
fill: isFocal ? 'rgba(0,0,0,0.8)' : 'rgba(0,0,0,0.35)'
```

### Caption
```js
ctx.font = '11px serif';
ctx.fillStyle = '#666';
ctx.textAlign = 'left';
ctx.fillText('Description of what this shows', pad.left, H - pad.bottom + 20);
```
