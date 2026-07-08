# Reflect Design System (2026 UI refresh)

Canonical visual and interaction reference. Screen-specific behavior lives in per-screen specs; this document defines shared tokens, components, and patterns.

**Entry point:** [`README.md`](README.md)  
**Per-screen specs:** [`today-screen.md`](today-screen.md), [`new-task-screen.md`](new-task-screen.md), [`new-goal-screen.md`](new-goal-screen.md), [`daily-review-screen.md`](daily-review-screen.md)

## Colors

| Token | Hex | Usage |
|-------|-----|--------|
| `accentPrimary` | `#7A9E9F` | FAB, progress, active nav, primary buttons, links |
| `accentSoft` | `#E8F0F0` | Active nav pill, selected chip washes |
| `pageBackground` | `#FAFAF8` | Scaffold background |
| `cardSurface` | `#FFFFFF` | Cards |
| `inputSurface` | `#F5F5F3` | Text fields |
| `textPrimary` | `#1A1A1A` | Titles, body |
| `textSecondary` | `#8A8A8A` | Metadata, section labels |
| `overdue` | `#C45C5C` | Overdue section and cues |

## Priority lozenges

Glow-dot capsules — tinted wash, colored dot with soft halo, matching label text. Not solid filled badges.

| Priority | Dot / label | Wash |
|----------|-------------|------|
| P1 | `#C45C5C` | ~10% coral |
| P2 | `#C49A6C` | ~10% amber |
| P3 | `#7A8FA8` | ~10% slate |
| P4 | `#9A9A9A` | ~10% gray |

## Typography

- **Font:** Inter
- **Page title:** `headlineMedium`, bold
- **Section label:** small caps, `textSecondary`, letter-spacing 1.2
- **Card title:** `titleMedium`, semibold

## Shared components (`lib/core/presentation/widgets/`)

| Widget | Purpose |
|--------|---------|
| `PriorityLozenge` | Priority display/selection |
| `ReflectPill` | When, time, tags, chips |
| `ReflectSectionLabel` | OVERDUE, TODAY, TASKS |
| `ReflectFormCard` | Grouped form sections |
| `ReflectSoftField` | Borderless soft inputs |
| `ReflectPrimaryButton` | Sticky bottom CTA |
| `ReflectIconButton` | Header filter/sort |
| `ReflectProgressBar` | Today progress |
| `ExpandableSectionRow` | Repeats, KPI accordion |
| `MoodRatingRow` | Daily review mood |
| `ReflectFab` | List screen FAB |

## Navigation

- **Bottom nav:** 5 tabs; active = `accentSoft` pill + `accentPrimary` icon/label
- **FAB:** 16px rounded square, `accentPrimary`, white `+`

## Interaction patterns

- **Date/time pills:** tap → picker; × clears; tap active When pill again clears date
- **Expand rows:** chevron accordion (not toggle switch) for Repeats / KPI
- **Forms:** hero title borderless; sage-teal CTA pinned to bottom

## Code

Tokens: [`lib/core/presentation/theme/reflect_colors.dart`](../../lib/core/presentation/theme/reflect_colors.dart)  
Theme: [`lib/core/presentation/theme/app_theme.dart`](../../lib/core/presentation/theme/app_theme.dart)
