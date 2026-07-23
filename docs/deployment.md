# Deployment & CI — Reflect

How code flows from feature branches to App Testers and (eventually) production stores.

## Branch model

| Branch | Role | Who merges | Direct push |
|--------|------|------------|-------------|
| **`develop`** | Integration / QA (default on GitHub) | PR only | **Blocked** |
| **`main`** | Production release line | PR only (from `develop`) | **Blocked** |
| **`feature/*`, `chore/*`, …** | Day-to-day work | PR → `develop` | Allowed on feature branches |

```text
feature/chore/bugfix branches  ──PR──►  develop  ──PR──►  main
                                              │              │
                                         App Tester      App Tester*
                                         (QA build)   (prod line; Play Store later)
```

\* **`main` builds are distributed to App Tester temporarily.** When Google Play Console is configured, `main` merges will upload to Play internal/production track instead (or in addition). Until then, both branches use Firebase App Distribution → `qa-team`.

## CI workflow

Workflow: [`.github/workflows/firebase_distribution.yml`](../.github/workflows/firebase_distribution.yml)

| Event | Branches | Jobs |
|-------|----------|------|
| **Pull request** | `develop`, `main` | `test` only (lint, coverage ≥ 99%) |
| **Push (merge)** | `develop` | `test` → `deploy` → Firebase App Distribution |
| **Push (merge)** | `main` | `test` → `deploy` → Firebase App Distribution (interim) |

**No APK is built on PRs** — only after merge to `develop` or `main`.

### Build configuration (both branches)

- **Environment:** production (`.env.production`, `--dart-define=ENV=production`)
- **Signing:** release keystore from GitHub secrets
- **Build number:** `github.run_number` (monotonic; see [`versioning.md`](versioning.md))
- **Tester group:** `qa-team` (same group for develop and main until Play Console is wired)

Release notes are **generated automatically** on every deploy by [`tool/generate_release_notes.sh`](../tool/generate_release_notes.sh):

1. **Header** — channel label, `pubspec.yaml` version, CI build number, short SHA
2. **PR summary** — when the push is a merge commit, the merged PR **title** and **body** (via `gh` + `GITHUB_TOKEN`)
3. **Commits** — conventional commit subjects from `github.event.before..github.sha`

Firebase receives the output via `release-notes-file` in the distribution action.

### Tips for useful tester notes

- Use **Conventional Commits** in PR branches (`feat:`, `fix:`, …) — they appear in the Commits section
- Fill in the PR **Summary** and **Changes** sections — they are copied into the release notes on merge
- Bump `pubspec.yaml` **version** on PRs that should read as a new release to testers

## Version bumps

Bump `MAJOR.MINOR.PATCH` in `pubspec.yaml` on PRs that should produce a meaningful tester release. CI ignores the `+BUILD` suffix and injects `github.run_number` as `versionCode`.

## GitHub configuration (one-time)

### 1. Default branch

**Settings → General → Default branch** → `develop` (already set).

### 2. Branch protection — `develop`

**Settings → Branches → Add branch protection rule** → branch name `develop`:

- [x] **Require a pull request before merging**
  - [ ] Require approvals (off for solo dev; enable when team grows)
- [x] **Require status checks to pass before merging**
  - Required check: **`Test & Coverage`** (job name from workflow)
- [x] **Require branches to be up to date before merging** (recommended)
- [x] **Do not allow bypassing the above settings**
- [x] **Restrict who can push to matching branches** — leave empty to block everyone except merges via PR (no direct pushes)
- [ ] Require linear history (optional)

### 3. Branch protection — `main`

Same as `develop`, plus:

- [x] **Require a pull request before merging**
- [x] **Require status checks:** `Test & Coverage`
- Consider **Restrict pushes that create matching branches** if available
- Document team policy: **only merge to `main` from `develop`** (release PRs). GitHub cannot enforce source branch without Rulesets:

**Optional (recommended):** **Settings → Rules → Rulesets** → rule for `main`:

- Target: `main`
- Require pull request
- **Required source branch:** `develop` (GitHub Rulesets support "require branches to be up to date" and branch name patterns for PRs)

### 4. Repository secrets

Already required for deploy (see [`security.md`](security.md) and playbook §12):

| Secret | Purpose |
|--------|---------|
| `ENV_PRODUCTION_BASE64` | `.env.production` for release APK |
| `KEYSTORE_BASE64` | Android upload keystore |
| `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD` | Signing |
| `FIREBASE_CREDENTIALS_BASE64` | App Distribution service account |
| `FIREBASE_APP_ID` | Firebase Android app ID |

### 5. Actions permissions

**Settings → Actions → General** → Workflow permissions: **Read and write** (for artifacts; distribution action needs default token).

## Release flow

### Day-to-day (features)

1. Branch from `develop`: `git checkout develop && git pull && git checkout -b feature/my-change`
2. Open PR **into `develop`**
3. Pass CI → merge
4. CI builds APK → Firebase App Distribution → `qa-team`

### Production line (when ready to promote)

1. Open PR **`develop` → `main`** with release notes and version bump if needed
2. Pass CI → merge
3. CI builds production-line APK → App Tester (interim)
4. **Future:** add Play Console upload job on `main` only; keep or remove interim App Tester per release policy

## Local commands

| Command | Use |
|---------|-----|
| `make run-dev` | Local dev (`.env.testing`) |
| `make run-prod` | Local prod flavor smoke test |
| `make build-prod-apk` | Local signed release build |

CI does **not** use `make build-prod-apk`; it inlines `flutter build apk` with CI secrets.

## Related docs

- [`CONTRIBUTING.md`](../CONTRIBUTING.md) — branching & PR conventions
- [`versioning.md`](versioning.md) — SemVer & build numbers
- [`security.md`](security.md) — secrets & CI cleanup
- [`testing.md`](testing.md) — coverage gate (99%)
