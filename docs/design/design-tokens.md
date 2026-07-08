# Design tokens — Reflect (UI refresh)

> **Superseded by [`design-system.md`](design-system.md)** — use that file as the canonical reference. This file is kept as a quick token lookup.

## Accent & surfaces

| Token | Value | Usage |
|-------|-------|--------|
| Accent primary | `#7A9E9F` | FAB, progress fill, active nav, primary buttons, links |
| Accent soft | `#E8F0F0` | Active nav pill, subtle fills |
| Page background | `#FAFAF8` | Screen scaffold background |
| Card surface | `#FFFFFF` | Task cards, form section cards |
| Input surface | `#F5F5F3` | Text fields, notes areas |

## Text

| Token | Value | Usage |
|-------|-------|--------|
| Text primary | `#1A1A1A` | Titles, task names |
| Text secondary | `#8A8A8A` | Metadata, section hints |
| Overdue label | `#C45C5C` | OVERDUE section header, relative overdue cues |

## Priority lozenges (“glow dot”)

Small horizontal capsules — **not** solid filled badges.

| Priority | Dot + label color | Wash background |
|----------|-------------------|-----------------|
| P1 | `#C45C5C` (soft coral) | ~8–12% coral tint |
| P2 | `#C49A6C` (warm honey) | ~8–12% amber tint |
| P3 | `#7A8FA8` (slate blue) | ~8–12% blue-gray tint |
| P4 | `#9A9A9A` (neutral) | ~8–12% gray tint |

Structure: tinted wash → small colored dot with soft halo → `P1`/`P2`/… label in matching hue. No harsh borders.

## Typography

- Family: Inter (existing app font)
- Section labels: small caps, secondary color, letter-spaced
- Task titles: semibold, primary color
- Metadata: `bodySmall`, secondary color

## Components (cross-screen)

- **Progress bar:** ~4px height, accent fill, no pie chart on Today
- **Filters:** top-right header row (funnel + sort), not beside TASKS label
- **FAB:** rounded square, accent fill, white `+` icon
- **Bottom nav:** 5 tabs; active tab uses accent soft pill behind icon
