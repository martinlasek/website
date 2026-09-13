---
name: blog-graphic
description: Create explanatory screenshots, diagrams, and data charts for Martin Lasek's blog posts, with accurate content and visually verified SVG or raster assets.
---

# Inline blog graphics

Adapted from `wishkit-api/.claude/skills/blog-graphic` on 2026-09-09. Carry over its attention to evidence, labels, spacing, and visual verification while using this site's design.

## Choose the useful visual

- For a Swift tutorial, prefer a screenshot of the result, a before/after comparison, or a diagram of the behavior being explained.
- For a project story, show a real interface or a relevant process. Label conceptual mockups clearly; do not present them as screenshots of working software.
- For numerical comparisons, chart verified inputs with units, dates, and definitions. Unknown values remain unknown, never zero or fabricated estimates.
- Put the graphic near the paragraph it explains. A short post need not have a graphic when text or code already explains the point clearly.

## Construct and verify

- Use SVG/code for precise diagrams and charts; use the available image-generation skill when a raster illustration benefits the post. Preserve meaningful existing screenshots and GIFs.
- Follow the site's chosen fonts and colors. A width of 1200 pixels is a useful source size; let the height fit the content. Check legibility at the actual mobile display size.
- Prefer direct labels for simple charts. Include source and definitional caveats inside shareable data graphics so the context survives sharing.
- Calculate label and element bounds. Leave room between headings, bar values, arrows, captions, and the footer. A rounded bar's corner radius must not exceed half its height.
- Make arrows and their directions clear. For converging flows, use an intentional merge point; compute arrowheads from the path direction.
- If replicating a product interface, use the real proportions and controls. Keep editorial annotations outside the represented interface.
- Ensure highlights differ visibly from their backgrounds and text has adequate contrast. Do not rely solely on color to communicate meaning.
- Render and inspect the complete output before embedding. After a spacing fix, recheck the entire affected container for new overlaps or alignment problems.
- If a reported image defect differs from the local asset, compare the served and local files before concluding it is a cache issue. Equal bytes alone do not rule out CSS or rendering defects.

## Assets and embedding

Follow the existing asset organization, or use `Public/images/blog/<post-slug>-<graphic-name>.{svg,png}` when adopting the proposed blog convention. Keep the editable source and render. Embed with useful alt text, responsive sizing, and dimensions/aspect ratio that reserve layout space. Include a text explanation or table for important data. Version filenames for materially changed cached production graphics and update their references.

## Optional references

These unchanged WishKit scripts are examples to read and adapt, not ready-to-run website tools. They contain WishKit branding, paths, and example claims. Reverify any data and replace product-specific components before reuse:

- [inline-graphic-example.py](references/wishkit/inline-graphic-example.py): SVG component and text layout examples.
- [batch-graphics-example.py](references/wishkit/batch-graphics-example.py): diagram and arrow construction examples.

Use the sibling `blog-cover` skill for covers and `seo-content` for research and publication checks.
