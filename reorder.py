import re

with open('docs/flutter-project-playbook.md', 'r') as f:
    lines = f.readlines()

# Let's find the line numbers for each main section
sections = [
    "## Table of Contents\n",
    "## 0. Architectural Decisions & Planning\n",
    "## 1. Project Scaffolding\n",
    "## 2. Dependency Stack\n",
    "## 3. Clean Architecture Structure\n",
    "## 4. Code Generation Setup\n",
    "## 5. Environment & Secrets\n",
    "## 6. Makefile (Developer Shortcuts)\n",
    "## 7. Security Checklist\n",
    "## 8. Testing Conventions\n",
    "## 9. CI / CD with GitHub Actions\n",
    "## 10. Firebase Setup\n",
    "## 11. Versioning Strategy\n",
    "## 12. Documentation Framework\n",
    "## 13. AI Agent Rules (AGENTS.md)\n",
    "## 14. Production Readiness Checklist\n"
]

indices = {}
for i, line in enumerate(lines):
    if line in sections:
        indices[line] = i
indices['EOF'] = len(lines)

# build section text
section_content = {}
ordered_keys = [
    "## Table of Contents\n",
    "## 0. Architectural Decisions & Planning\n",
    "## 1. Project Scaffolding\n",
    "## 2. Dependency Stack\n",
    "## 3. Clean Architecture Structure\n",
    "## 4. Code Generation Setup\n",
    "## 5. Environment & Secrets\n",
    "## 6. Makefile (Developer Shortcuts)\n",
    "## 7. Security Checklist\n",
    "## 8. Testing Conventions\n",
    "## 9. CI / CD with GitHub Actions\n",
    "## 10. Firebase Setup\n",
    "## 11. Versioning Strategy\n",
    "## 12. Documentation Framework\n",
    "## 13. AI Agent Rules (AGENTS.md)\n",
    "## 14. Production Readiness Checklist\n"
]

for idx, key in enumerate(ordered_keys):
    start = indices[key]
    end = indices[ordered_keys[idx+1]] if idx + 1 < len(ordered_keys) else indices['EOF']
    section_content[key] = "".join(lines[start:end])

# Now construct the new file
intro = "".join(lines[:indices["## Table of Contents\n"]])

toc = """## Table of Contents

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
15. [Production Readiness Checklist](#15-production-readiness-checklist)

---
"""

# Re-map and rename headers
new_order = [
    ("## 13. AI Agent Rules (AGENTS.md)\n", "## 1. AI Agent Initialization (AGENTS.md)\n"),
    ("## 0. Architectural Decisions & Planning\n", "## 2. Architectural Decisions & Planning\n"),
    ("## 1. Project Scaffolding\n", "## 3. Project Scaffolding\n"),
    ("## 2. Dependency Stack\n", "## 4. Dependency Stack\n"),
    ("## 3. Clean Architecture Structure\n", "## 5. Clean Architecture Structure\n"),
    ("## 4. Code Generation Setup\n", "## 6. Code Generation Setup\n"),
    ("## 5. Environment & Secrets\n", "## 7. Environment & Secrets\n"),
    ("## 6. Makefile (Developer Shortcuts)\n", "## 8. Makefile (Developer Shortcuts)\n"),
    ("## 7. Security Checklist\n", "## 9. Security Checklist\n"),
    ("## 8. Testing Conventions\n", "## 10. Testing Conventions\n"),
    ("## 9. CI / CD with GitHub Actions\n", "## 11. CI / CD with GitHub Actions\n"),
    ("## 10. Firebase Setup\n", "## 12. Firebase Setup\n"),
    ("## 11. Versioning Strategy\n", "## 13. Versioning Strategy\n"),
    ("## 12. Documentation Framework\n", "## 14. Documentation Framework\n"),
    ("## 14. Production Readiness Checklist\n", "## 15. Production Readiness Checklist\n")
]

new_file_content = intro + toc
for old_key, new_header in new_order:
    content = section_content[old_key]
    # replace the first line which is the header
    content = new_header + content[len(old_key):]
    new_file_content += content

with open('docs/flutter-project-playbook.md', 'w') as f:
    f.write(new_file_content)

