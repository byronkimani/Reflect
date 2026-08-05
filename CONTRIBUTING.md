# Contributing Guidelines

Thank you for contributing to Reflect. Please follow these guidelines to ensure a smooth collaboration process.

## Branching Strategy & Environments

We follow a **GitFlow-lite** model suitable for mobile applications:

1. **`main` (Production)**
   - `main` is the production branch.
   - It is a **protected branch**. You **cannot** push or commit directly to `main`.
   - Releases to App Store / Play Store are cut from this branch.

2. **`develop` (Staging/Integration)**
   - `develop` is the main integration branch.
   - It is a **protected branch**. You **cannot** push or commit directly to `develop`.
   - All feature branches, bug fixes, and chores must branch off from `develop`.
   - Once your work is reviewed and approved via Pull Request, it is merged into `develop`.

### Workflow

1. Ensure you are on `develop` and have pulled the latest changes.
2. Create a new branch: `git checkout -b feature/your-feature-name` (or `bugfix/...`, `chore/...`).
3. Make your changes, ensure code generation is run (`make gen`), and run tests (`make test`).
4. Commit your changes.
5. Push your branch and open a Pull Request against `develop`.
6. Once approved, tested, and passing CI (GitHub Actions), merge the PR into `develop`.
7. Merging to `develop` triggers a **QA APK** build to Firebase App Distribution (`qa-team`). See [`docs/deployment.md`](docs/deployment.md).

### Promoting to production (`main`)

`main` is the production branch. **Do not push directly to `main`.**

1. When `develop` is ready for a production-line release, open a PR **`develop` → `main`**.
2. Include release notes and bump `pubspec.yaml` version if needed (see [`docs/versioning.md`](docs/versioning.md)).
3. After CI passes, merge the PR.
4. Merging to `main` triggers a **production-line APK** to App Tester **temporarily** (Google Play upload will replace this in a future workflow update).

Full CI/CD and GitHub branch protection steps: [`docs/deployment.md`](docs/deployment.md).

## Commit Rules and Conventions

We strictly enforce the **[Conventional Commits](https://www.conventionalcommits.org/)** standard for all commit messages.

### Format

```
<type>(<scope>): <subject>

<optional body — use blank line after subject; bullet lists OK>

<optional footer>
```

**Example (title + bullet body):**

```
feat(ui): ship Paper & Ink refresh and iOS splash fix

Implement v2 visual refresh and fix congested iOS launch splash.

- Add theme tokens and shared v2 widgets
- Regenerate app icon and splash assets via make splash
- Update tests and docs; remove obsolete design spec links
```

### Types

- **`feat`**: A new feature
- **`fix`**: A bug fix
- **`docs`**: Documentation only changes
- **`style`**: Changes that do not affect the meaning of the code (formatting, etc.)
- **`refactor`**: A code change that neither fixes a bug nor adds a feature
- **`test`**: Adding missing tests or correcting existing tests
- **`chore`**: Changes to the build process or auxiliary tools and libraries

### Guidelines

- **Subject**: Use the imperative, present tense (e.g., "add daily planning" not "added daily planning").
- **AI Agents**: AI agents are explicitly forbidden from committing directly to `main` or `develop` and must create a branch first.

## Code Generation

Reflect heavily uses `build_runner` for Freezed models, Drift database, and JSON serialization.

If you modify any file containing `@freezed`, `@JsonSerializable`, `@DriftDatabase`, or `@DriftAccessor`, you **must** run code generation before committing:

```bash
make gen
```

Failure to do so will result in CI failure.

## Testing

All new logic requires tests (Unit, Widget, and Integration depending on the layer). Read the full policy in [`docs/testing.md`](docs/testing.md).
