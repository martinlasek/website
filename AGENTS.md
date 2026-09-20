# Personal website

This repository contains Martin Lasek's Swift/Vapor personal website.

## Release ownership

Martin handles all commits, pushes, and deployments. Assistants may edit files, run local checks, and prepare review notes, but must not commit, push, deploy, or trigger a release. Leave those actions to Martin; do not interpret a general "sounds good" or "let's do it" as permission to perform them.

## Shared publishing skills

Claude skills live in `.claude/skills/`. Codex discovers the same folders through relative symlinks in `.agents/skills/`, so both assistants use one maintained copy.

- [seo-content](.claude/skills/seo-content/SKILL.md): blog writing, refreshes, metadata, URL migration, and Search Console analysis.
- [blog-cover](.claude/skills/blog-cover/SKILL.md): cover and social preview assets.
- [blog-graphic](.claude/skills/blog-graphic/SKILL.md): explanatory diagrams, screenshots, and charts.

Read the relevant skill when the task calls for it. They were adapted from WishKit; the helper scripts under `references/wishkit/` are historical examples requiring adaptation before execution here.

Before implementing Swift changes, use the available `swift-guideline` skill and only its relevant references.
