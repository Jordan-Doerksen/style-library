# External references

Outside libraries worth raiding for ideas — not dependencies. Daybreak Editorial stays
vanilla, build-free, `file://`-safe (see the laws in `README.md`); nothing here gets
`npm install`ed into it. Treat these as a feature/pattern catalog: study the effect, port
the *idea* into `effects.js` / `style.css` by hand.

| Site | What it is | Possible lift for Daybreak | Status |
|---|---|---|---|
| [Paper Shaders](https://shaders.paper.design/) | Zero-dep GLSL shader library (gradients, noise, glass, liquid metal) | Hand-port a lightweight noise/gradient shader for the `.sun` or hero background — richer than the current CSS grain, still no deps | **Built** — `shader.js`, canvas noise blobs on `#sun` |
| [React Bits](https://reactbits.dev/) | Animated React component gallery | Motion/easing reference for `.reveal`, ticker, and card-tilt timing — copy the *feel*, not the component | Queued |
| [Aceternity](https://aceternity.com/) | Paid dev agency (not a free lib) — its older UI gallery popularized "animated Tailwind block" patterns | Interaction-pattern inspiration only (spotlight/hover-glow effects); nothing to install | Queued |
| [shadcn/ui](https://ui.shadcn.com/docs/components) | The base accessible component system most modern React kits build on | Structural reference for component states (focus rings, disabled/hover variants) to make sure `.btn`/`.card` cover the same state matrix | **Built** — state matrix in `style.css` (disabled/loading/pressed/aria-current) |
| [Untitled UI (React)](https://www.untitledui.com/react/components) | Large open-source component set, Tailwind v4 + React Aria | Layout/composition reference for dashboards and marketing blocks if a project ever needs those shapes | Queued |
| [Kibo UI](https://www.kibo-ui.com/components/contribution-graph) | shadcn-registry niche widgets (e.g. GitHub contribution graph) | A vanilla contribution-graph / heatmap widget could join `.stats` as a new Daybreak component | Queued (not picked in the 2026-07-07 pass) |
| [React Aria (Adobe)](https://react-aria.adobe.com/) | Unstyled, fully accessible interaction primitives (a11y engine under several kits above) | Accessibility checklist reference — keyboard nav / ARIA patterns to retrofit onto `.card`, `.ticker`, any custom widget | **Built** — `cmdk.js`, the combobox/listbox keyboard pattern |
| [MotionSites](https://motionsites.ai/) | AI-generated animated landing-page template gallery | Hero/landing-page layout ideas, especially for [[client-pitch-site]] builds that need their own brand treatment | Queued |

**How to use this list:** before adding a new Daybreak component or effect, check here first —
if one of these sites already solved the interaction, borrow the idea and hand-build it to spec
(vanilla JS/CSS, reduced-motion safe, AA contrast, `file://`-safe). Don't add a framework
dependency to satisfy this list.
