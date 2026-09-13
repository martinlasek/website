---
name: blog-cover
description: Create or update cover and social preview images for Martin Lasek's blog, keeping typography, topic imagery, and branding consistent with the personal website.
---

# Blog cover images

Adapted from `wishkit-api/.claude/skills/blog-cover` on 2026-09-09. Reuse the repeatable cover workflow; follow this site's chosen visual direction rather than assuming WishKit's gradients or feedback-card motif.

## Create

- Inspect the current design and nearby post covers first. The personal site's redesign is still being discussed; do not treat WishKit's visual style as approved here.
- Prefer an existing useful screenshot, a topic-specific illustration, or clear typography. Covers should communicate the post's subject and remain legible as thumbnails.
- Use a 1200 by 630 canvas for a shared cover/social asset unless the established design specifies another size. Keep titles concise and comfortably inside the canvas; measure text rather than relying on a character limit.
- Use the site's typography and palette. Check actual foreground/background contrast, including across gradients; do not assume an inherited palette has passed contrast checks.
- For code-native vector artwork, author SVG and render a PNG for social sharing. Use the available image-generation skill for AI-created raster illustrations when appropriate.
- Use Martin Lasek or martinlasek.com for a brand mark when the design calls for one. Avoid importing WishKit logos or motifs unless the post is actually about WishKit.

## Verify and integrate

Render the full image without cropping and inspect it at native size and thumbnail size. Check title wrapping, clipping, margins, contrast, and the appearance alongside neighboring covers. If using `rsvg-convert`, a typical command is:

```sh
rsvg-convert -w 1200 -h 630 path/to/cover.svg -o path/to/cover.png
```

Use the established asset directory; `Public/images/blog/<slug>.{svg,png}` is a proposed convention if a new blog directory is introduced. Keep editable sources beside rendered output. Supply actual dimensions and appropriate alt text when embedding. Use the absolute PNG URL in social metadata and post structured data, and keep the post registry and visible cover aligned. Version an already-published asset's filename when needed to invalidate caches.

## Optional reference

[generate_cover.py](references/wishkit/generate_cover.py) is the original WishKit SVG generator, copied unchanged as a layout example. It writes WishKit-branded files, assumes its output directory exists, and interpolates raw text. Before using it here, adapt the motif, mark, paths, XML escaping, input handling, and text sizing. Do not run it as a ready-made generator for this site.

Use the sibling `seo-content` skill for publication metadata and URL migration, and `blog-graphic` for explanatory visuals inside a post.
