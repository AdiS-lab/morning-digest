# Brutalist-Pointillist-Minimalist Design Skill

> **Status:** Experimental. Actively being refined through testing.

## Overview

A Claude Code skill for generating web designs that fuse three aesthetics into coherent, fast, production-ready output.

- **Brutalist** — Content-first. Raw HTML structure. Default browser fonts and link styles. No decorative CSS unless it earns its place. The content IS the design.
- **Pointillist** — When visuals are needed, build them from dots, spheres, and particles using structured mathematical sampling. Forms rendered via dot density, not random scatter.
- **Minimalist** — Maximum restraint. Nothing unnecessary. Every element must justify its existence.

## Core Philosophy

**The content comes first. Visuals come second, and only when they explain something or are genuinely compelling.** A page of raw HTML with good writing is better than a designed page with mediocre content. Start with zero CSS and add only what's needed.

### What "brutalist" means here
- Default browser fonts (Times, serif). Not Google Fonts. Not monospace-for-aesthetic.
- Default link colors (blue, purple visited). Not styled links.
- No border-radius. No shadows. No gradients.
- No em dashes. Use periods or commas instead.
- Spacing doesn't have to be perfect. Browser defaults are fine.
- If it looks like a Craigslist page with good writing, you're in the right zone.

### What "AI slop" looks like (avoid this)
- Every font is the same carefully chosen Google Font
- Perfectly spaced sections with identical padding
- Decorative shapes placed next to content for no reason
- Dark mode with accent colors and monospace labels
- Splitting the page in half (content left, visual right) as a default layout
- Visual elements that don't relate to the content
- Over-designed, over-styled, over-polished

## Core Requirements

1. **Content-first** — Write something worth reading. The words matter more than the presentation.
2. **Honest** — Don't decorate. If there's a visual element, it should explain something or be genuinely interesting. A loss curve belongs on a page about training. A wireframe pyramid does not belong on a portfolio.
3. **Fast** — Lightweight. Prefer zero dependencies. When a library is needed (Rough.js, Three.js), justify it.
4. **Imperfect** — Bake in roughness. Use Rough.js for hand-drawn diagrams. Avoid pixel-perfect rendering. The aesthetic is chalkboard, not Figma.

## Visual Demos

Visuals are not decoration. They are explanations. Include a visual demo ONLY when:
- It explains a concept that words alone can't (attention patterns, embedding spaces, loss curves)
- It is genuinely compelling and you'd want to look at it
- It relates directly to the content on the page

### Rough.js for Hand-Drawn Diagrams
The default rendering library for diagrams. Draws to Canvas with a wobbly, sketched quality.

```html
<script src="https://unpkg.com/roughjs@4.6.6/bundled/rough.js"></script>
```

```js
const rc = rough.canvas(canvas);
rc.line(x1, y1, x2, y2, { stroke: '#333', roughness: 1.2 });
rc.rectangle(x, y, w, h, { fill: 'rgba(0,0,0,0.3)', fillStyle: 'solid', roughness: 0.5 });
rc.circle(cx, cy, diameter, { fill: '#000', stroke: 'none', roughness: 0.5 });
```

Use cases proven in testing:
- **Loss curves** — Axes + exponential decay curve. Explains training.
- **Attention arc diagrams** — Tokens along a baseline, arcs connecting them with thickness = attention weight. Shows how the model resolves coreference.
- **Attention matrices** — NxN grid, cell darkness = attention strength. Shows the full picture.
- **3D embedding spaces** — Words as labeled points in rotatable 3D space, clustered by meaning. Drag to rotate. Depth cues via size and opacity.

### 3D with Rough.js (no Three.js needed for wireframes)
For wireframe 3D (rotating point clouds, embedding spaces), use manual projection:

```js
function project(p, rotX, rotY) {
  // Rotate Y
  let x = p.x * Math.cos(rotY) - p.z * Math.sin(rotY);
  let z = p.x * Math.sin(rotY) + p.z * Math.cos(rotY);
  let y = p.y;
  // Rotate X
  let y2 = y * Math.cos(rotX) - z * Math.sin(rotX);
  let z2 = y * Math.sin(rotX) + z * Math.cos(rotX);
  // Perspective
  const fov = 3;
  const scale = fov / (fov + z2);
  return {
    x: W/2 + x * scale * 200,
    y: H/2 - y2 * scale * 200,
    z: z2,
    scale: scale
  };
}
```

Mouse-drag rotation: redraw on drag. The Rough.js wobble changes each redraw, which makes the sketch feel alive.

### When to use Three.js
Only for true 3D scenes with thousands of points where Canvas can't keep up. Fibonacci sphere compositions, particle fields with bloom/post-processing. NOT for wireframe diagrams.

### Pointillist Techniques (for when dots are the right choice)
When dot-based rendering IS appropriate (terrain planes, density visualizations):

**R2 Quasi-Random Sequence** (for rectangles/planes):
```
g = 1.32471795724
a1 = 1/g, a2 = 1/g²
x_i = (0.5 + a1 * i) mod 1
y_i = (0.5 + a2 * i) mod 1
```

**Fibonacci Spiral** (for circles):
```
golden_angle = π * (3 - √5)
angle = i * golden_angle
r = √(i / N) * radius
```

**Fibonacci Sphere** (for 3D spheres):
```
y = 1 - (2 * i / (N - 1))
radius_at_y = √(1 - y²)
θ = golden_angle * i
x = cos(θ) * radius_at_y
z = sin(θ) * radius_at_y
```

## Page Structure

A page is a self-contained HTML file. The pattern that works:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Title</title>
  <!-- Rough.js only if there's a diagram -->
</head>
<body>
  <h1>Title</h1>
  <p><a href="index.html">back</a></p>
  <hr>
  <!-- Content: paragraphs, lists, pre blocks, blockquotes -->
  <!-- Canvas element ONLY where a diagram earns its place -->
  <hr>
  <p><a href="index.html">back</a></p>
  <script>
    // Diagram code, if any
  </script>
</body>
</html>
```

No CSS unless absolutely necessary. Default everything. Navigation is plain links.

## Site Structure

Pages link to each other with plain `<a>` tags. The home page has a Links section with all subpages listed. Each subpage has a "back" link at the top and bottom. No routing, no SPA, no build step. Just HTML files.

## Writing Style

- Short sentences. Direct.
- No em dashes. Use periods.
- Explain things honestly, including uncertainty.
- Technical content in `<pre>` tags, not styled code blocks.
- Lists for lists. Paragraphs for prose. Don't overthink it.

## Testing

Test outputs live in `./tests/`. Each test is a self-contained HTML file.

### Tests that worked
- `test-08-claude-site.html` — Raw HTML portfolio. Zero CSS. Content-first. The breakthrough.
- `history.html` — Blog-style page with Rough.js loss curve. Visual earns its place.
- `attention.html` — Arc diagram + attention matrix. Complex Rough.js demo that explains a real concept.
- `embeddings.html` — 3D rotatable word embedding space. Most complex demo. Mouse-drag interaction.

### Tests that failed (and why)
- `test-02-landing-page.html` — Over-designed. Google Fonts, accent colors, monospace labels, feature grids. AI slop.
- `test-04-portfolio.html` — Same problem. Styled cards, dot thumbnails as decoration, designed spacing.
- `test-05-brutalist-portfolio.html` — Content/visual split layout. Pointillist terrain as decoration. Visual didn't relate to content.
- `test-06-brutalist-a/b/c.html` — Shapes as decoration (spinning square, Mondrian lines, pulsing circle). No relationship to content.
- `test-07-wireframe-pyramid.html` — Rough.js pyramid. Right rendering technique, wrong concept. The pyramid had nothing to do with Claude.

### Key lesson
The failed tests all share one trait: visuals that don't relate to content. The successful tests all share one trait: visuals that explain the content. The rendering technique (Rough.js) is the same. The difference is whether the visual earns its place.

## Open Questions

- How to handle pointillist terrain/landscape compositions. They look good in isolation but failed as page decoration. Where do they belong?
- Should Three.js Fibonacci spheres be reserved for standalone art pieces rather than page elements?
- How to define "compelling enough" for a visual to earn its place on a page.
- Naming: "Brutalist-Pointillist"? "Dot Brutalism"? TBD.
