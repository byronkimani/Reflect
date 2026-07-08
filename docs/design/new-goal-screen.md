# New Goal / Edit Goal screen — approved design

**Status:** Approved (2026-07-08)  
**Reference mock:** [`mocks/mock-new-goal-refined-accordion.png`](mocks/mock-new-goal-refined-accordion.png)  
**Tokens:** [`design-tokens.md`](design-tokens.md)

## Goals

- Accordion-based form — avoid long overwhelming scroll
- Single **Importance** control (replaces separate Priority + Urgency)
- KPI via **expand row** (like Repeats on New Task)
- Match sage-teal accent and pill/chip patterns from Tasks

## Layout

**Always visible**

- Hero: “What do you want to achieve?” (required)
- Time frame pills: Weekly · Monthly · Quarterly · Yearly (create only)
- Category chips + manage categories

**Accordion sections**

| Section | Default | Contents |
|---------|---------|----------|
| **Timeline** | Open | Start/target date pills (picker, × clear, tap-active to clear); check-in frequency pills |
| **Measure** | Collapsed | “Track a KPI” expand row → KPI description, start/target values |
| **Motivation** | Open | Why (multiline) + description |
| **Importance** | Collapsed | Combined importance control (see below) |

## Importance (replaces Priority + Urgency)

Single control — not duplicate P1–P4 rows.

| Level | Maps to `priority` + `urgency` |
|-------|-------------------------------|
| Low | P4 / P4 |
| Medium | P3 / P3 |
| High | P2 / P2 |
| Critical | P1 / P1 |

Tap selected level again to clear (optional both null).

## KPI expand row

- Collapsed: “Track a KPI” + chevron down, `isMeasurable = false`
- Expanded: KPI description, start value, target value; `isMeasurable = true`
- Collapsing: keep values in state but `isMeasurable = false` until re-expanded (match Repeats pattern)

## Date pills

Same as New Task: tap → picker; × to clear; tap active pill to clear.

## Primary action

Sticky bottom **Create Goal** / **Save Changes** (sage-teal).

## Archive mocks

- [`mock-new-goal-direction-a-quick-capture.png`](mocks/mock-new-goal-direction-a-quick-capture.png)
- [`mock-new-goal-direction-b-grouped-cards.png`](mocks/mock-new-goal-direction-b-grouped-cards.png)
- [`mock-new-goal-direction-c-accordion.png`](mocks/mock-new-goal-direction-c-accordion.png)

## Implementation

- Refactor `goal_form_page.dart` presentation
- Importance mapper in presentation or cubit helper
- Reuse date pill / expand-row widgets from New Task where possible
