<!--
  Reflect Flutter App
  Engineering conventions: AGENTS.md. Typical checks: make lint, make test, make gen;
-->

## Summary

<!-- What changed and why. Link to issue: Closes #___ -->

## Type of Change

- [ ] Bug fix | [ ] New feature | [ ] Breaking change
- [ ] Refactor | [ ] Performance | [ ] Deps | [ ] Docs

## Flutter Impact

- [ ] New packages added to pubspec.yaml
- [ ] Drift schema migration needed
- [ ] Code generation run (`make gen`)
- [ ] Platform-specific changes (iOS/Android native code)
- [ ] New GoRouter routes added
- [ ] New BLoC/Cubit added
- [ ] UI/Design system changes

## Changes

<!-- Brief file-by-file summary -->

## How to Test

1.
2.

<!-- e.g. make lint, make test, manual device testing steps -->

## Screenshots

<!-- Before / after for UI changes -->

## Checklist

- [ ] Tests added/updated: happy-path **and** failure/edge (unit / widget / bloc_test as appropriate)
- [ ] Filtered coverage ≥ 98% (`make coverage`)
- [ ] No debug code or hardcoded secrets
- [ ] Linter passes (`make lint`) with **zero** analyzer issues and no bypassed rules
- [ ] Error states handled
- [ ] `docs/implementation-status.md` updated (if delivery state changed)

## Deployment Notes

- [ ] New env vars needed in `.env.*`
- [ ] Safe to deploy independently
