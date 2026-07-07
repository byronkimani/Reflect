import re

with open('docs/flutter-project-playbook.md', 'r') as f:
    text = f.read()

# 1. Replace TOC
old_toc = """## Table of Contents

1. [AI Agent Initialization (AGENTS.md)](#1-ai-agent-initialization-agentsmd)
2. [Architectural Decisions & Planning](#2-architectural-decisions--planning)
3. [Project Scaffolding](#3-project-scaffolding)
4. [Dependency Stack](#4-dependency-stack)
5. [Clean Architecture Structure](#5-clean-architecture-structure)
6. [Code Generation Setup](#6-code-generation-setup)
7. [Environment & Secrets](#7-environment--secrets)
8. [Makefile (Developer Shortcuts)](#8-makefile-developer-shortcuts)
9. [Security Checklist](#9-security-checklist)
10. [Testing Conventions](#10-testing-conventions)
11. [CI / CD with GitHub Actions](#11-ci--cd-with-github-actions)
12. [Firebase Setup](#12-firebase-setup)
13. [Versioning Strategy](#13-versioning-strategy)
14. [Documentation Framework](#14-documentation-framework)
15. [Production Readiness Checklist](#15-production-readiness-checklist)"""

new_toc = """## Table of Contents

0. [The Master Bootstrap Prompt](#0-the-master-bootstrap-prompt)
1. [AI Agent Initialization (AGENTS.md)](#1-ai-agent-initialization-agentsmd)
2. [Architectural Decisions & Planning](#2-architectural-decisions--planning)
3. [Project Scaffolding](#3-project-scaffolding)
4. [Dependency Stack](#4-dependency-stack)
5. [Clean Architecture Structure](#5-clean-architecture-structure)
6. [Code Generation Setup](#6-code-generation-setup)
7. [Dependency Injection Setup](#7-dependency-injection-setup)
8. [Environment & Secrets](#8-environment--secrets)
9. [Makefile (Developer Shortcuts)](#9-makefile-developer-shortcuts)
10. [Security Checklist](#10-security-checklist)
11. [Testing Conventions](#11-testing-conventions)
12. [CI / CD with GitHub Actions](#12-ci--cd-with-github-actions)
13. [Firebase Setup](#13-firebase-setup)
14. [Versioning Strategy](#14-versioning-strategy)
15. [Documentation Framework & Ways of Working](#15-documentation-framework--ways-of-working)
16. [Production Readiness Checklist](#16-production-readiness-checklist)"""

text = text.replace(old_toc, new_toc)

# 2. Insert Section 0
section_0 = """---

## 0. The Master Bootstrap Prompt

To completely bootstrap a production-ready app from zero, **simply copy the prompt below and paste it to your AI agent.** 

> **Goal:** I want to bootstrap a new Flutter application named `[Your App Name]`.
> 
> **Instructions:**
> Please read the `docs/flutter-project-playbook.md` file and execute the entire bootstrap process in chronological order (Sections 1 through 15). 
> 
> - **Stop at Section 2:** You must interview me on the key architectural decisions (State Management, Storage, Networking, Routing, UI) and **wait for my answers** before scaffolding anything.
> - **Execute completely:** Once we align on architecture, proceed through the rest of the playbook (Scaffold, Dependencies, Clean Architecture, CodeGen, Dependency Injection, Environments, Makefiles, Security, Testing, CI/CD, and Documentation). 
> - Generate all the exact boilerplate files, workflows, and markdown docs instructed in the playbook. 
> 
> What are your architectural questions from Section 2?
"""
text = text.replace("---", section_0, 1) if text.count("---") > 1 else text.replace("## 1. AI Agent", section_0 + "\n## 1. AI Agent") # Fallback replacement using re

text = re.sub(r'(---\n+## 1\. AI Agent Initialization)', section_0 + r'\1', text)

# 3. Rename old sections 7 to 15
# We have to iterate backwards to prevent 11 turning into 12, then 12 turning into 13, etc.
for i in range(15, 6, -1):
    text = text.replace(f"## {i}. ", f"## {i+1}. ")

# 4. Insert Section 7 (DI Setup) before the new Section 8
section_7 = """## 7. Dependency Injection Setup

We use `get_it` as our service locator. The AI agent must automatically scaffold this pattern.

1. Create `lib/core/di/injectors.dart`.
2. Add a `setupDependencies()` function.
3. Call `setupDependencies()` in `main.dart` before `runApp()`.

**Pattern:**
- `registerLazySingleton`: For Repositories, Services, and Databases.
- `registerFactory`: For BLoCs/Cubits (to ensure fresh state on navigation).

```dart
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // e.g. getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
}
```

---

"""
text = text.replace("## 8. Environment & Secrets", section_7 + "## 8. Environment & Secrets")

# 5. Overwrite the new Section 15 (old 14) Documentation Framework
old_doc_framework_start = text.find("## 15. Documentation Framework")
old_doc_framework_end = text.find("## 16. Production Readiness Checklist")

new_doc_framework = """## 15. Documentation Framework & Ways of Working

The AI agent must generate a full `docs/` directory upon bootstrap. We follow a **Continuous Documenting Process** where documentation and spec are updated alongside every feature.

### Base Files to Generate at Bootstrap:

1. **`README.md` (root)** — App overview, architecture summary, and setup/run instructions.
2. **`ARCHITECTURE.md` (root)** — Layer diagram (Clean Architecture), boundaries, and the tech stack agreed upon in Section 2.
3. **`docs/README.md`** — A central index linking to all other docs.
4. **`docs/agent-map.md`** — A mental map/index to help AI agents quickly look up where domain models, screens, and configs live without searching.
5. **`docs/implementation-status.md`** — A strict tracker of features marked as `Shipped`, `In-Progress`, or `Planned`.
6. **`docs/collaboration-framework.md`** — Rules governing the AI-User brainstorm process (e.g. "No code before spec", "Offline-first alignment").
7. **`docs/di.md`** — Documentation on how `get_it` is structured in the app.
8. **`docs/state-management.md`, `docs/database.md`, `docs/routing.md`** — Brief summaries of conventions for each domain based on Section 2's answers.

### Continuous Documenting Process (Agent Rule)

- The agent must operate in a **Spec-First** manner. Code is not written until a markdown spec is reviewed.
- Whenever the agent adds a new feature or alters a database schema, it **must proactively update all related documents** (especially `implementation-status.md` and `ARCHITECTURE.md`).

---

"""
text = text[:old_doc_framework_start] + new_doc_framework + text[old_doc_framework_end:]

with open('docs/flutter-project-playbook.md', 'w') as f:
    f.write(text)

