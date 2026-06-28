# Collaboration Framework — Reflect

> **Status:** Active  
> **Purpose:** Global rules governing the AI-User collaboration and brainstorming process to prevent context loss, ensure alignment, and maintain consistency.

## 1. The Golden Rule of Clarification

**The AI must never assume.** At the end of every single prompt or specification draft, the AI must explicitly ask:
- "What clarifications, adjustments, or corrections are needed?"
- Ask specific, targeted questions about any ambiguous UI or business logic encountered during the draft.

## 2. No Code Before Spec

- We operate in a **Spec-First** manner for new features.
- Application code (Flutter UI, BLoC, Domain logic) will not be written until the markdown specification for that module is reviewed.

## 3. Scope Progression (The 3-Step Scope)

When brainstorming a new feature, tackle it in this order to prevent scope creep:
1. **The Happy Path:** How does it work when everything goes perfectly?
2. **Edge Cases & Blockers:** What happens when things fail (no network, empty states)?
3. **Metrics & Persistence:** How is this saved to SQLite? What analytics apply?

## 4. Single Source of Truth (SSOT) Adherence

- **Offline-First Alignment:** Every new feature must function offline first. If a feature relies strictly on a network call to work at all, it violates the core architecture and must be flagged.
- **Clean Architecture Boundary:** Any feature discussion must map to Presentation, Domain, and Data layers. Do not mix API calls into UI widgets during brainstorming or implementation.

## 5. Immediate Documentation & Cross-Document Cohesion

- Any new information, business rule, or architectural decision that comes up during brainstorming **must be immediately documented in all appropriate source-of-truth documents** (e.g., `ARCHITECTURE.md`, `database.md`, `state-management.md`).
- **The Cohesion Rule:** The AI must proactively search for and update **all related documents** so that the entire documentation suite tells the same cohesive story.

## 6. Code Generation Awareness

- The AI must explicitly prompt or remind the user that `make gen` needs to be run whenever it modifies a class that uses `@freezed`, `@JsonSerializable`, or Drift annotations. 
- The AI will not attempt to manually write or edit generated files (`*.g.dart`, `*.freezed.dart`).
