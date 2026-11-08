# Geography Page Guidelines

## Purpose

Interactive reference maps for learning regions. Useful when reading news to understand where things are happening. Click a region, see its name, capital, and language.

## Stack

- D3.js v7 for rendering SVG maps
- TopoJSON v3 for parsing geographic data
- No CSS. Default browser everything.

## Architecture

One shared `makeMap()` helper handles all maps. Each map section needs:
1. A data URL (TopoJSON source)
2. A projection (how to center and scale the map)
3. A name extractor function (which property holds the region name)
4. A lookup object (name -> capital, language)

```js
makeMap(containerId, infoId, width, height, projection, dataUrl, objKeyFn, nameFn, lookupData);
```

## Adding a new country or region

1. Find a TopoJSON or GeoJSON source. Prefer gists or CDN-hosted files that won't disappear.
2. Fetch a sample and check: what is the `objects` key? What property holds the name?
3. Add a lookup object with `{name: {capital, lang}}` entries.
4. Add a `makeMap()` call with the right projection.

### Projection tips

- `d3.geoMercator()` works for most single-country maps. Set `.center([lon, lat])` and `.scale()`.
- `d3.geoAlbersUsa()` is specifically for the US (handles Alaska/Hawaii).
- `d3.geoNaturalEarth1()` is good for world maps.
- Trial and error on center/scale is normal. Start with the country's geographic center.

## Data sources that work

| Map | Source | Objects key | Name property |
|-----|--------|-------------|---------------|
| India | [anilnairxyz gist](https://gist.githubusercontent.com/anilnairxyz/1ca20f47982712cf6d4128064e3a6feb/raw/3e0c829745ebf567cb8e15399168ba2777ba1864/ne_10m_admin_1_India_Official.json) | `ne_10m_admin_1_India_Official` | `name` |
| US | `cdn.jsdelivr.net/npm/us-atlas@3/states-10m.json` | `states` | `name` |
| Russia | [logvik gist](https://gist.githubusercontent.com/logvik/cf787bda80a8aa125c84/raw/russia_mercator.json) | `name` | `NAME_1` |
| Middle East | `cdn.jsdelivr.net/npm/world-atlas@2/countries-110m.json` (filtered) | `countries` | `name` |

## Lookup object format

Keep it simple. Every entry is:

```js
'Region Name': {capital: 'Capital City', lang: 'Language(s)'}
```

Include alternate name spellings the TopoJSON might use. For example, India's data might say "NCT of Delhi" instead of "Delhi", so include both.

## Interaction

- Hover: lighten fill
- Click: darken fill, show info below the map
- Click again: deselect
- No quiz mode, no buttons. Just click and read.

## Middle East approach

Instead of a dedicated TopoJSON, the Middle East map filters the world-atlas by a list of country names and a bounding box. Neighboring countries are drawn lightly for context. Middle East countries are drawn on top with full interactivity.

## Future additions

- Cities within countries (would need a separate points layer, not polygons)
- Africa, East Asia, Europe as standalone sections
- District-level maps for India (udit-001/india-maps-data has this data)
