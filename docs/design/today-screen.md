# Today screen — approved design

**Status:** Approved (2026-07-07)  
**Reference mocks:** [`mocks/today-screen-v3-filters-top.png`](mocks/today-screen-v3-filters-top.png), [`mocks/today-screen-v4-expanded.png`](mocks/today-screen-v4-expanded.png)  
**Tokens:** [`design-tokens.md`](design-tokens.md)

## Goals

- Calm, focused home screen — not a dashboard
- Clear overdue vs today hierarchy without tomorrow/upcoming clutter
- Enough metadata to scan tasks; subtasks available inline without leaving the list

## Layout

```
┌ Header ─────────────────────────────────────┐
│ Good evening              [filter] [sort]   │
│ Tuesday, Jul 7                              │
│ ████████░░░░░░░░░░  1 of 3 done today       │
├ TASKS ──────────────────────────────────────┤
│ OVERDUE                                     │
│   [ task cards ]                            │
│ TODAY                                       │
│   [ task cards ]                            │
└ FAB (+)                          Bottom nav ┘
```

### Header

| Element | Behavior |
|---------|----------|
| Greeting | Time-based: Good morning / afternoon / evening |
| Date | `EEEE, MMM d` — large, bold |
| Filter + sort | **Top-right** circular icon buttons (not beside TASKS) |
| Progress | Thin horizontal bar + copy “N of M done today” — **no pie chart** |

### Sections

- **OVERDUE** — muted red small-caps label; tasks with relative due (e.g. “Yesterday”)
- **TODAY** — sage-teal small-caps label
- **No Tomorrow / Upcoming section** on this screen

Completed tasks: remain in list (strikethrough) at bottom of today group — existing product behavior.

## Task card — collapsed

| Row | Content |
|-----|---------|
| Primary | Checkbox · Title · Relative due (top-right when dated) |
| Metadata | Priority lozenge · Subtask chip · Tags (max 2 + “+N”) |

### Metadata rules

- **Relative due:** “Yesterday”, “3 days late”, “10:00 AM” when time set
- **Priority:** Glow-dot lozenge (see tokens) — always shown
- **Subtask chip:** `completed/total` + checklist icon + chevron when subtasks exist
- **Tags:** Soft chips with colored dot + name; max 2 visible, “+1” overflow

### Not on collapsed card

Notes, reminder bell, repeat label, goal name — defer to expanded footer / detail.

## Task card — expand / collapse

| Trigger | Action |
|---------|--------|
| Tap **title** | Toggle expand when subtasks exist |
| Tap **subtask chip** | Toggle expand |
| Tap **checkbox** | Complete / reopen only — does not expand |

### Expanded content

- Indented subtask rows with individual checkboxes
- Completed subtasks: checkmark + strikethrough
- Footer actions: **Edit** · **Reschedule** (both **Overdue** and **Today** tasks)

### Parent completion

When parent checkbox tapped and subtasks are incomplete → confirm dialog:

> “Mark all subtasks done too?”

Actions: **Complete all** · **Parent only** · **Cancel**

### Navigation to full detail

Card tap does **not** navigate. Use **Edit** in expanded footer (or dedicated entry elsewhere if added later).

## Interactions preserved from current app

- Swipe to delete (Slidable)
- Long-press selection mode
- Checkbox complete / reopen via `TaskListBloc`

## Out of scope (this spec)

- Backlog list card variant
- Filter sheet visual redesign
- Empty state illustration
