# Diagram Guidelines

## Core rules

- Library: **rough.js** always. `<script src="https://unpkg.com/roughjs@4.6.6/bundled/rough.js"></script>`
- Every "more" page needs at least one diagram. It must show something the text alone cannot.
- **Labels must never overlap** with the graph or each other. This is the most common bug. If two labels are within 20px, move one. Alternate timeline labels above and below. Put axis labels outside the plot area.
- Vary diagram types across pages in the same digest. Do not use the same type on every page.
- Never visualize human deaths as counted objects.

## Diagram types

| Type | Best for | Example |
|------|----------|---------|
| Timeline | Sequence of events | Ukraine war, impeachment history |
| Bar chart (horizontal) | Comparing named things | Oil chokepoints, market drops |
| Bar chart (vertical) | Few data points over time | Premiums by year |
| Line chart | Trends over time | Stock prices, aid over time |
| Seat map / grid | Composition | Senate seats, court justices |
| Table | Multi-dimension data | Investigation patterns |

Pick the type that matches the data. If the story is a trend, use a line chart. If it is a sequence, use a timeline. If it is a comparison, use a bar chart. Do not default to timelines and workflow boxes.

## Style

- Canvas width: 500-700px. `style="display:block; margin: 20px 0;"`
- **Color: default to black and gray.** Use `'rgba(0,0,0,0.6)'` for primary, `'rgba(0,0,0,0.2)'` for secondary. Only add color when it carries meaning (party colors, decline, absence). Keep it muted: `'#c33'`, `'#2a8c46'`, `'#2255aa'`.
- Roughness: 0.5-1.2. Fill style: `'solid'`.
- Text: `'11px serif'` for labels, `'12px serif'` for values, `'bold 11px serif'` for headers. Fill: `'#333'`.
- Axes: `stroke: '#333', roughness: 0.5`. Grid lines: `stroke: 'rgba(0,0,0,0.06)', roughness: 0.3`.
- Highlight the focal element with darker fill or thicker stroke. One thing should stand out.
- One caption line below each diagram.

## Common code

```js
const pad = { top: 20, right: 20, bottom: 40, left: 50 };
// Axes
rc.line(pad.left, pad.top, pad.left, H - pad.bottom, { stroke: '#333', roughness: 0.5 });
rc.line(pad.left, H - pad.bottom, W - pad.right, H - pad.bottom, { stroke: '#333', roughness: 0.5 });
// Caption
ctx.font = '11px serif';
ctx.fillStyle = '#666';
ctx.fillText('Description', pad.left, H - pad.bottom + 20);
```
