# Daily Review screen — approved design

**Status:** Approved (2026-07-08)  
**Direction:** C — Compact Cards (refined with mood icons + add-one-by-one gratitude)  
**Reference mock:** [`mocks/mock-daily-review-direction-c-approved.png`](mocks/mock-daily-review-direction-c-approved.png)  
**Tokens:** [`design-tokens.md`](design-tokens.md)  
**Implementation:** `lib/features/review/presentation/pages/daily_review_page.dart`

## Goals

- Calm, card-based single scroll — not a plain Material form
- Mood icons instead of numeric 1–5 segmented control
- Subtle task context without dashboard fatigue
- Gratitude feels inviting, not punitive
- Sage-teal accent aligned with Today / Tasks / Goals

## Layout

```
┌ Daily Review ─────────────────────────────┐
│ Wednesday, Jul 8                            │
│ [ 4 of 6 tasks done today ]   ← subtle chip │
├ CARD: Mood ─────────────────────────────────┤
│ How was your day?                           │
│ [😞] [😕] [😐] [🙂] [😊]  Rough … Great      │
├ CARD: Wins & Growth ────────────────────────┤
│ ☀ What went well?    [ soft input ]         │
│ 🌿 What could be better? [ soft input ]     │
├ CARD: Gratitude ────────────────────────────┤
│ Share up to 3 things                        │
│ ♡ I am grateful for…                        │
│ + Add another                               │
├ [ Save Review ]                             │
└─────────────────────────────────────────────┘
```

Single scroll — all three cards visible (no wizard).

## Header

| Element | Notes |
|---------|-------|
| Title | **Daily Review** |
| Date | `EEEE, MMM d` — secondary gray below title |
| Task chip | **Subtle pill** e.g. “4 of 6 tasks done today” from `taskCompletionRate` + task counts; omit if no tasks today |

## Card 1 — Mood

- Prompt: **“How was your day?”**
- **Five mood icons** (left = rough, right = great) — maps internally to `dayRating` 1–5
- Selected: sage-teal ring / glow
- Hint labels only at ends: **Rough** · **Great**
- **Required** to submit

## Card 2 — Wins & Growth

| Field | Icon | Placeholder |
|-------|------|-------------|
| What went well? | Soft sun/amber | “A win from today…” |
| What could be better? | Soft leaf/sage | “One thing to improve…” |

- Short soft rounded inputs (not harsh `OutlineInputBorder`)
- **Submit rule:** at least **one** of the two fields must be non-empty

## Card 3 — Gratitude

- Title: **Gratitude**
- Helper: **“Share up to 3 things”** (not “3 mandatory”)
- **Add one-by-one:**
  - Start with **one** field visible
  - **+ Add another** link (sage-teal) until 3 fields shown
  - Teal heart **outline** icon (not bright pink filled)
- **First gratitude field** must be non-empty to submit; additional fields (2–3) may be left empty
- **+ Remove** (X) on fields 2–3 to dismiss an accidentally added row

## Primary action

- Sticky bottom **Save Review** — sage-teal, full width, rounded `16px`
- Disabled until `canSubmit`; loading spinner when `isSubmitting`

## Submit validation (`canSubmit` update)

```text
dayRating > 0
AND (wentWell.isNotEmpty OR couldBeBetter.isNotEmpty)
AND gratitude1.isNotEmpty (when gratitude section is shown)
```

Additional gratitude fields (2–3) are optional even when visible.

## Archive mocks

- [`mock-daily-review-direction-a-evening-journal.png`](mocks/mock-daily-review-direction-a-evening-journal.png)
- [`mock-daily-review-direction-b-guided-flow.png`](mocks/mock-daily-review-direction-b-guided-flow.png)
- [`mock-daily-review-direction-c-compact-cards.png`](mocks/mock-daily-review-direction-c-compact-cards.png) — initial C exploration (dot scale)

## Implementation notes

- `MoodRatingRow` widget: icon index + 1 → `ratingChanged`
- Load task completion on page init → `completionRateChanged` + display chip
- Update `DailyReviewState.canSubmit` for reflection + dynamic gratitude count
- Widget tests: mood selection, add gratitude field, submit enabled/disabled
