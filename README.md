# Style Template Library

A small, build-free library of **skins** — full visual atmospheres you can drop onto any
project. One layout, many vibes: a `data-skin` attribute on `<html>` swaps the palette,
the background, and the hero centrepiece. Nothing in the markup moves.

Born from [The Observatory](https://jordan-doerksen.github.io). Vanilla HTML/CSS/JS, no
dependencies, no build step.

**Running the demo:** the picker and the canvas backgrounds load as ES modules, which
browsers block over `file://` — so double-clicking `index.html` shows a styled page but a
dead picker. Serve it over HTTP instead: double-click **`serve.bat`** (Windows), or run
`python -m http.server` in this folder, then open <http://localhost:8000>. (Dropping the
library into a project that's already served works fine — this only bites the local demo.)

```
style-library/
  index.html        demo + the canonical wiring example
  tokens.css        the control panel — palette, button tokens, fonts, rhythm (= Observatory)
  skins.css         framework — the --sky-*/--hero-motif defaults + the picker UI
  buttons.css       the locked button system (solid primary, ghost secondary)
  demo.css          page chrome for the demo only (not part of the payload)
  skins/
    sentinel · daybreak · military · angelic · demonic · nature · chic · pro   (.css overrides)
  serve.bat         double-click to preview locally (starts a server + opens the browser)
  camo-cadpat.svg   CADPAT tile for the Military background
  engine/
    skins.js        the picker + data-skin switcher (initSkins)
    sky.js + sky/   background dispatcher + renderers (nightsky, datarain, daylight, hudfield, aurora, plain)
    hero.js + hero/ hero dispatcher + renderers (jd, dataeye, sunrise, targetlock, seraph)
    cursor-fx.js    per-skin cursor trail + click FX (initCursorFx)
```

## The skins

| Skin | Mode | Palette in one line | Background | Hero |
|------|------|---------------------|-----------|------|
| **Observatory** | dark | the default — deep indigo, one gold thread | starfield + nebula | the J·D constellation |
| **Sentinel** | dark | the red watcher; teal kept for live data only | falling red data-rain | an eye of data that tracks the cursor |
| **Daybreak** | light | warm paper, bronze thread, solid panels | warm daylight + clouds | a sun rising over clouds |
| **Military** | dark | CADPAT olive void, tactical-lime thread, holo-cyan data, amber alerts | HUD field — dot grid, drifting cursor-reactive reticles, floating telemetry tags, parallaxing CADPAT camo (needs `camo-cadpat.svg`) | a targeting reticle that locks onto the cursor (RNG/AZ readout) |
| **Angelic** | light | luminous pearl, soft-gold thread, celestial-blue accent | aurora veils + bokeh orbs + halo rings, combined | sacred-geometry seraph (counter-rotating Flower-of-Life lattice, cursor-reactive) |
| **Demonic** | dark | hellfire obsidian, molten-orange thread, sulfur + ember-red | summoning sigils — pulsing runes, rotating circles, smoke, hell-glow | a summoning sigil-gate (rune ring + counter-rotating pentagram + molten core) |
| **Nature** | light | misty alpine — soft mist, evergreen thread, river-cyan | full-page valley — parallaxing ridgelines, treeline, winding river w/ ducks/fish/logs, mist + pollen | a glowing tree of life (branches grow in, leaf-nodes pulse, wind-sway to cursor) |
| **Chic** | dark | champagne noir — charcoal, champagne-gold thread, ivory | drifting gold dust — fine motes twinkling under a faint gold haze | a brilliant-cut gem that rotates + turns its facets to the cursor's light |
| **Pro** | light | pinstripe & ink — ivory, ink-navy thread, oxblood accent | a live quant terminal — grid + code-rain + candlestick tape + a cursor-seeking node-network | a rotating wireframe globe with linked nodes + data-pulses |

Observatory is just the bare defaults in `tokens.css` + `skins.css` — there's no
`skins/observatory.css`. The other skins are overrides keyed on `:root[data-skin="…"]`.

## The rules that make it work

- **Buttons are token-driven, never uniform.** The primary CTA carries the skin's identity
  colour, so it can't be one shared look. Two archetypes:
  - `.btn-primary` = a **solid** accent fill (`--btn-fill`) + an ink picked for contrast on
    that fill (`--btn-ink`). Never a low-opacity wash; never inherited light text.
  - `.btn` (ghost) = transparent + the **body text colour** (`--text`, already correct per
    skin) + an accent border.
- **`--gold-ink`** is the thread colour but *safe as small text*: it equals the accent on
  dark skins and a deepened value on light skins. Use it for links, labels, ornaments —
  anywhere the accent has to carry text. The vivid accent stays for the thread and borders.
- **Light skins use solid panels.** Glass blur behind text on a light background is brutal
  to read, so Daybreak overrides `.glass-panel` to opaque paper with `backdrop-filter: none`.
- **`prefers-reduced-motion` is law.** Both canvases render a single static frame.

The one-line version: *on a light skin, a filled button uses a deep fill so dark-enough ink
reads, and a ghost button uses body text — never the accent as text.* That kills
light-on-light forever.

## Drop it into a project

1. Copy `tokens.css`, `skins.css`, `buttons.css`, and the `skins/` + `engine/` folders in. (For the Military skin, also copy `camo-cadpat.svg` to the library root — `hudfield.js` resolves it relative to itself via `import.meta.url`.)
2. In your `<head>`, **before** any stylesheet, restore the saved skin so there's no flash:
   ```html
   <script>try{var s=localStorage.getItem('obs-skin');if(s)document.documentElement.dataset.skin=s;}catch(e){}</script>
   ```
3. Link the CSS (tokens first, then skins, then your component CSS, then each skin file):
   ```html
   <link rel="stylesheet" href="tokens.css" />
   <link rel="stylesheet" href="skins.css" />
   <link rel="stylesheet" href="buttons.css" />
   <link rel="stylesheet" href="skins/sentinel.css" />
   <link rel="stylesheet" href="skins/daybreak.css" />
   <link rel="stylesheet" href="skins/military.css" />
   ```
4. Add the two canvases — the background and the hero centrepiece:
   ```html
   <canvas id="sky" aria-hidden="true"></canvas>
   <canvas id="sigil" role="img" aria-label="…"></canvas>
   ```
   `#sky` should be `position: fixed; inset: 0; z-index: -2; pointer-events: none;` (see
   `demo.css`). `#sigil` is sized by your layout. Both are optional — omit a canvas and that
   dispatcher simply no-ops.
5. Init the engine:
   ```html
   <script type="module">
     import { initSkins } from './engine/skins.js';
     import { initSky } from './engine/sky.js';
     import { initHero } from './engine/hero.js';
     import { initCursorFx } from './engine/cursor-fx.js';
     initSkins(); initSky(); initHero(); initCursorFx();
   </script>
   ```
   `initCursorFx()` gives each skin its own cursor trail + click FX (fine pointer
   only; skipped under reduced motion). It hides the native cursor via the
   `has-cursor` class — that rule ships in `skins.css`.

## How a skin is built (and how to add one)

A skin is a CSS file plus, optionally, a background renderer and a hero renderer.

```css
:root[data-skin="myskin"] {
  --bg: …; --panel: …; --text: …; --gold: …; --accent: …;   /* palette */
  --btn-fill: …; --btn-ink: …; --btn-border: …;             /* primary button */
  --gold-ink: …;                                            /* accent-as-text (deepen on light) */
  --sky-mode: datarain;                                     /* a renderer in engine/sky/ */
  --hero-motif: dataeye;                                    /* a renderer in engine/hero/ */
}
```

Then register the skin in `engine/skins.js` (`SKINS` array). A renderer is a factory:

```js
export function makeMyRenderer(ctx) {
  return {
    // still: true,   // set this for a static background (no rAF loop)
    resize(w, h, skin) { /* cache sizes; skin has the resolved palette */ },
    frame(dt, env) { /* one animated frame; env = { w, h, t, … , skin } */ },
    static(env) { /* one still frame — used for reduced-motion */ },
  };
}
```

Add it to the `RENDERERS` map in `engine/sky.js` (or the `MOTIFS` map in `engine/hero.js`)
under the key you used for `--sky-mode` / `--hero-motif`. The dispatcher owns the canvas,
DPR/resize, the animation loop, visibility pausing, reduced-motion, and replays the hero's
entrance on every skin change — your renderer just draws.

**All nine looks are built** (Observatory + the eight `skins/` overrides). Add a new one by
following the recipe above — one at a time.

## License

MIT — see [LICENSE](LICENSE).
