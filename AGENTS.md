# Personal website

This repository contains Martin Lasek's Swift/Vapor personal website.

## Shared publishing skills

Claude skills live in `.claude/skills/`. Codex discovers the same folders through relative symlinks in `.agents/skills/`, so both assistants use one maintained copy.

- [seo-content](.claude/skills/seo-content/SKILL.md): blog writing, refreshes, metadata, URL migration, and Search Console analysis.
- [blog-cover](.claude/skills/blog-cover/SKILL.md): cover and social preview assets.
- [blog-graphic](.claude/skills/blog-graphic/SKILL.md): explanatory diagrams, screenshots, and charts.

Read the relevant skill when the task calls for it. They were adapted from WishKit; the helper scripts under `references/wishkit/` are historical examples requiring adaptation before execution here.

Before implementing Swift changes, use the available `swift-guideline` skill and only its relevant references.
