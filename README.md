# style-library — Daybreak Editorial

Jordan's house style. Warm editorial light on paper, one Goldenrod thread, technical
fonts, and cards with real tactile depth. It's the canonical design system for personal
work — the tokens, the components, the laws. If anything labelled "Daybreak Editorial"
disagrees with the files in this repo, the repo wins. `index.html` is the reference page;
it shows every component in one place.

---

## Use it

Link the two stylesheets (tokens first, always), add the effects script, and drop in the
scaffolding elements. Give the hero its `id`.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>…</title>
  <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="tokens.css">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <svg class="grain" aria-hidden="true">
    <filter id="paperNoise"><feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" stitchTiles="stitch"/></filter>
    <rect width="100%" height="100%" filter="url(#paperNoise)"/>
  </svg>
  <div class="rules" aria-hidden="true"></div>
  <div class="sun" id="sun" aria-hidden="true"></div>
  <div class="cursor" id="cursor" aria-hidden="true"></div>

  <div class="wrap">
    <main id="top">
      <section class="hero" aria-labelledby="hero-h">
        <p class="eyebrow">Eyebrow</p>
        <h1 id="hero-h" class="reveal">I make things that <em>work.</em></h1>
      </section>
    </main>
  </div>

  <script src="effects.js" defer></script>
</body>
</html>
```

The four scaffolding elements — `.grain`, `.rules`, `.sun`, `.cursor` — carry the paper
texture, the editorial gutters, the drifting sun, and the ink-dot cursor. They live outside
`.wrap` at `z-index:0`. Content goes inside `.wrap` (the `--maxw` column with `--mar`
gutters).

---

## Tokens

Everything reads from `tokens.css`. Don't hardcode a colour — use the variable.

**Palette** — warm paper under a drifting sun.

| Token | Value | Role |
|---|---|---|
| `--paper` | `#f6f1e7` | Background. Never pure white. |
| `--paper-2` | `#fbf8f1` | Raised surfaces, card tops |
| `--ink` | `#17140f` | Text |
| `--muted` | `#6f685c` | Secondary text |
| `--hair` | `#d8cfbf` | Hairlines, borders |
| `--accent` | `#b8860b` | Goldenrod — raw hue for fills, shapes, spines |
| `--accent-ink` | `#8a6508` | AA-safe text shade (5.9:1 on paper) — accent words, links |
| `--accent-rgb` | `184,134,11` | For `rgba()` tints (`--accent-soft`/`-tint`/`-line` derive from it) |

Rule of thumb: `--accent` paints things; `--accent-ink` writes words. Never set accent text
to the raw hue — it fails contrast.

**Type — locked to "Technical."** Three voices, strict roles.

| Token | Font | Role |
|---|---|---|
| `--display` | Space Grotesk | Hero, headings, big numerals — the artwork |
| `--sans` | Inter | Body copy, UI |
| `--mono` | JetBrains Mono | Labels, tags, eyebrows, spec lines — uppercase, wide tracking |

**Layout** — `--mar` (fluid gutter) and `--maxw` (`1180px` content column).

**Card depth** — `--card-rest` and `--card-hover`, two layered warm-brown shadow stacks
(inset top highlight + tight contact + broad ambient) that grow on hover. Cards get their
elevation from these, not from a flat `box-shadow`.

---

## Components

Class names, so downstream projects stay consistent.

- **Buttons** — `.btn` base; `.btn-primary` (solid Goldenrod) and `.btn-ghost` (outline).
- **Depth cards** — `.card`, the star. Material gradient surface, accent spine, raised tag
  chips, a stacked-paper layer for thickness, spec line on hover. Put them in a `.work` grid.
- **Category tiles** — `.cat` in a `.cat-grid`. A lighter touch of the same tactility.
- **Eyebrow** — `.eyebrow`, mono uppercase with the ✦ lead.
- **Stat strip** — `.stats` / `.stat` with `.num` + `.lbl`; `.num[data-count]` counts up.
- **Ticker** — `.ticker` / `.ticker__track` / `.ticker__item`, an editorial marquee.
- **Editorial structure** — `.rules` (symmetric gutter hairlines), `.sec-head` with `.idx`,
  `.reveal` (fades up on scroll).

---

## effects.js hooks

The script wires behaviour to specific ids and classes. Missing ones are ignored — include
what you use, skip what you don't.

| Hook | Behaviour |
|---|---|
| `#hero-h` | Splits into words and rises on load (`.hl-word` wrappers added for you) |
| `.reveal` | Fades up when scrolled into view |
| `[data-count]` | Counts from 0 to the target once, on view |
| `.card` | 3D tilt toward the cursor + lift on hover |
| `#magnet` | Magnetic button — drifts toward the cursor within a few px |
| `#cursor` | Ink-dot cursor that swells over interactive elements |
| `#sun` | Parallax drift with the cursor |

Everything is wrapped for `file://` (no fetch, no modules; localStorage in try/catch).

---

## The laws

- `prefers-reduced-motion` kills all motion. Non-negotiable. Cards hold a static elevated
  state, the cursor and ticker stop, reveals show immediately.
- AA contrast, always. Accent text uses `--accent-ink`, never the raw hue.
- One Goldenrod thread. It's the only accent. Don't add a second colour.
- ✦ is the ornament. The only one.
- `file://`-safe when single-file. It has to open by double-click, no server.

---

## Voice

Dry, deadpan, understated — the lack of effort is the joke. One line of personality, then
get out of the way. No exclamation marks, no marketing breathlessness, honest about gaps.

---

The old Glass Archive system is retired to `legacy-glass-archive/`. It's kept for reference,
not for new work.
