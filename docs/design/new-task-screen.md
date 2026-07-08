# New Task / Edit Task screen — approved design

**Status:** Approved (updated 2026-07-07)  
**Base:** Direction B (Quick Capture), simplified schedule (no duplicate date/time rows)  
**Reference mocks:**
- [`mocks/new-task-state1-repeats-collapsed.png`](mocks/new-task-state1-repeats-collapsed.png) — default
- [`mocks/new-task-state2-repeats-expanded-weekly.png`](mocks/new-task-state2-repeats-expanded-weekly.png) — repeats expanded  
**Tokens:** [`design-tokens.md`](design-tokens.md)

## Goals

- Fast task capture — title + When pills first
- Date/time set **only via pills/chips** (no secondary schedule date/time rows)
- Repeats UI hidden until user explicitly expands **Repeats** row
- Match Today screen: glow-dot priority lozenges, sage-teal accent

## Layout (top → bottom)

```
┌ App bar: ← New Task ────────────────────────┐
│ What needs doing?                             │
│ ●P4  ○P1  ○P2  ○P3                            │
│ When: [Today] [Tomorrow] [Pick date / Jul 12] │
│       [Add time / 10:00 AM]                   │
│ Remind me when due                      [toggle]│
│ Repeats                                    [▼]  │
│   (expanded) Daily | Weekly · Mon Wed Fri …     │
│ Subtasks …                                    │
│ Notes, goal & tags                          > │
│ [ Create Task ]                               │
└───────────────────────────────────────────────┘
```

**Removed:** Schedule card with date/time grid rows below When pills.

---

## State 1 — Default (repeats collapsed)

See mock: [`new-task-state1-repeats-collapsed.png`](mocks/new-task-state1-repeats-collapsed.png)

| Element | Appearance |
|---------|------------|
| When | **Today** selected (sage-teal); Tomorrow / Pick date outline |
| Time | **Add time** outline chip (clock icon) |
| Reminder | Toggle row, default **off** |
| Repeats | Collapsed row with chevron **down** — **no** Daily/Weekly/weekday UI |
| Subtasks / deferred / CTA | Unchanged |

---

## State 2 — Repeats expanded (weekly)

See mock: [`new-task-state2-repeats-expanded-weekly.png`](mocks/new-task-state2-repeats-expanded-weekly.png)

| Element | Appearance |
|---------|------------|
| When | **Pick date** selected; pill label shows picked date (**Jul 12**) |
| Time | Chip shows **10:00 AM** (replaces “Add time”) |
| Repeats | Row chevron **up**; expanded block below |
| Recurrence | **Weekly** selected; presets (Weekdays / Every day / Weekend) + Mon–Sun chips |

---

## Interaction spec

### When pills (mutually exclusive)

| Pill | Tap behavior | Selected appearance |
|------|--------------|---------------------|
| **Today** | Sets due date to local today | Sage-teal fill |
| **Tomorrow** | Sets due date to local tomorrow | Sage-teal fill |
| **Pick date** | Opens system **date picker** | Sage-teal fill; label becomes formatted date (e.g. `Jul 12`, `MMM d`) |

- Only one pill selected at a time.
- If picked date equals today/tomorrow, pill still shows the **date string** (not the word “Today”/“Tomorrow”) — user is in “Pick date” state.

**Clear date**

| Action | Result |
|--------|--------|
| Tap **active When pill** again (Today / Tomorrow / Pick date while selected) | Clears due date; no pill selected; **Pick date** label resets |
| Tap **×** on selected pill (when date is set) | Same as above |

Show a small **×** affordance on the trailing edge of the selected When pill when a date is active.

### Time chip

| State | Tap behavior |
|-------|--------------|
| **Add time** (outline) | Opens system **time picker** |
| **10:00 AM** (filled subtle) | Tap chip body to open time picker and change |

**Clear time**

| Action | Result |
|--------|--------|
| Tap **×** on time chip (when time is set) | Clears due time; chip reverts to **Add time** outline |

Show **×** on the time chip only when a time value is set. Tapping the chip body (not ×) always opens the picker.

- Available **anytime** (even without a due date — backlog-compatible).
- Maps to `dueTimeChanged` / clear via empty `dueTime`.

### Reminder

- Standard **toggle** row: “Remind me when due”
- Maps to `hasEnabledReminderChanged`

### Repeats (expand row — not a toggle)

| State | UI |
|-------|-----|
| **Collapsed** | Row: repeat icon + “Repeats” + chevron down. `isRepeating` = false. No frequency UI. |
| **Expanded** | Chevron up. Sets `isRepeating` = true. Shows recurrence controls below. |

- Tap **Repeats row** to expand/collapse (accordion).
- Collapsing sets `isRepeating` false and hides frequency UI.

**When expanded:**

- Segmented: **Daily** | **Weekly**
- Weekly only: preset chips + Mon–Sun toggles (existing cubit APIs)
- Reuse `recurrenceFrequencyChanged`, `recurrenceDaysOfWeekChanged`, `toggleRecurrenceDay`

### Subtasks

- Inline drag rows + **+ Add step** (sage-teal link)

### Notes, goal & tags

- Collapsed row → bottom sheet (notes, goal dropdown, tags)

### Primary action

- Sticky **Create Task** / **Save changes** (edit mode)

---

## Field parity (`TaskFormCubit`)

| Field | UI location |
|-------|-------------|
| Title | Hero |
| Priority | Lozenge row |
| Due date | When pills only |
| Due time | Time chip only |
| Reminder | Toggle row |
| Repeats + frequency | Expandable Repeats row |
| Subtasks | Subtasks section |
| Goal / notes / tags | Deferred sheet |

---

## Implementation notes

- Add presentation helpers: `setDueToday()`, `setDueTomorrow()`, sync pick-date pill label with `dueDate`
- `TaskFormView` refactor in `task_detail_page.dart`; new widgets: `WhenPills`, `TimeChip`, `RepeatsExpansionTile`
- No schema changes

## Archive

Superseded mock (schedule grid): [`new-task-b-plus-schedule-approved.png`](mocks/new-task-b-plus-schedule-approved.png)
