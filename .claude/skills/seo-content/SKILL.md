---
name: seo-content
description: Plan, write, refresh, and review SEO content for Martin Lasek's personal website, including Swift tutorials, blog posts, project stories, article URL migrations, and Search Console analysis.
---

# SEO content for martinlasek.com

Adapted from `wishkit-api/.claude/skills/seo-content` on 2026-09-09. Preserve its useful practices: original content, verified sources, honest dates, coherent metadata, useful illustrations, and measured updates. This is a personal publication; WishKit's conversion strategy, competitor-link policy, pricing, indexing quotas, and commercial calls to action do not apply here.

## Repository context

- The site currently renders HTML with Swift/Vapor and HtmlVaporSupport. Leaf is a dependency, but WishKit's Leaf blog templates do not exist here.
- Posts currently live in `Sources/App/Article/Page/`; their model and registry are in `Sources/App/Article/Article.swift` and rendering in `Article+Layout.swift`.
- Routes and the XML sitemap at `/sitemap` are in `Sources/App/routes.swift`.
- Shared metadata lives in `Sources/App/Views/Layout/Base/PageBuilder+Head.swift` and `Sources/App/Protocols/MetaTagProvider.swift`.
- Public tutorial images live in `Public/articles/`. Inspect the current implementation before edits; these paths may change during the redesign.
- Apply the available Swift guideline skill before implementing Swift changes.

## Research and writing

1. Identify the reader's question and the concrete answer or experience the post contributes. Check the existing archive before creating an overlapping post. Prefer improving an existing answer when the intent is the same.
2. For tutorials, lead with the problem, result, and applicable platform/tool versions. Show the smallest useful example, explain why it works, and include relevant limitations. Preserve working code and useful screenshots during migration.
3. For project stories, describe what Martin built, the decisions involved, and lessons supported by actual experience. Do not invent first-person anecdotes, usage numbers, testing, or outcomes.
4. Verify changing API behavior, compatibility, prices, and product claims against current primary sources. Link the supporting documentation beside the claim. Distinguish documentation research from hands-on testing.
5. Quotes must be verbatim from a source opened in the current session, attributed and linked, within applicable quotation limits. Use paraphrases when exact wording adds no value.
6. Write prose for this specific post. Shared layout is useful; repeated generic introductions and conclusions are not. FAQ sections belong only where they answer real remaining questions.
7. Use `blog-cover` when creating a cover or social image and `blog-graphic` when a screenshot, diagram, or chart helps explain the content. A short note need not acquire a decorative graphic just to satisfy a template.

## Metadata and discovery

- Use a descriptive page title, useful meta description, one main heading, and logical subheadings. List cards use subordinate headings.
- Provide a visible author byline linked to the About page, the original publication date, and a modified date when a substantive update warrants it.
- Keep visible dates, `BlogPosting` structured data, and sitemap dates consistent. A migration or restyle does not republish an old article. Do not automatically change dates for typos or link-only edits.
- Keep the canonical URL, `og:url`, structured data URL, internal links, and sitemap aligned. Use real absolute raster-image URLs for social metadata.
- Add appropriate `BlogPosting` JSON-LD for individual posts; it must describe visible content. Escape data through a serializer rather than concatenating untrusted strings into JSON or script tags.
- Every new post should be linked from the blog index and relevant existing content. Add canonical, indexable URLs to the sitemap and use accurate `lastmod` values where known.
- Check that important text is present in server-rendered HTML, assets resolve, meaningful images have descriptive alt text, and layouts work on mobile.
- Special AI text files or markup are not prerequisites for Google AI features. Do not introduce `llms.txt` or promise rankings as an SEO shortcut.
- After an authorized deployment, report changed URLs and any useful Search Console follow-up. Do not claim a sitemap was submitted or a page indexed without evidence, or transfer WishKit's observed quotas to this property.

## Articles becoming blog posts

Changing the navigation label to Blog does not require changing existing URLs. If Martin chooses `/blog/<slug>`, map each `/articles/<slug>` to its matching new page with a permanent server redirect; do not send every old article to the blog index. Preserve original slugs where practical, dates, code, images, and fragment anchors. Update internal links, canonical tags, social URLs, structured data, and the sitemap together. Verify that each old URL redirects directly to its final working page, unknown URLs return 404, and no redirect chains or loops exist. Keep redirects for at least a year, ideally indefinitely.

## Search Console analysis

Use actual exports when supplied; do not assume this site inherits WishKit's performance. Page totals and query totals are separate aggregations and cannot establish which page ranks for a query. Use page-filtered query data for that question. Compare equal time windows, assess clicks, impressions, CTR, and position together, and account for query intent, seasonality, and migrations. Low CTR alone does not establish AI Overview exposure. Make a focused change tied to evidence and allow an appropriate comparison window before judging it.

## Optional WishKit implementation references

The unchanged helpers below were copied for reference, not as runnable tools for this site's current Swift content format. Read only the relevant one when adapting an implementation:

- [post-scaffold.py](references/wishkit/post-scaffold.py): Leaf post structure. It contains WishKit branding, prices, URLs, and calls to action that must be replaced before reuse.
- [chart-lib.py](references/wishkit/chart-lib.py): SVG chart layout; adapt its branding, inputs, and output paths.
- [duplicate-paragraphs.py](references/wishkit/duplicate-paragraphs.py): repeated-prose detection for Leaf files. Adapt to actual content or rendered HTML before running; zero scanned files is not a successful content check.

## Primary guidance

- [Google: helpful content](https://developers.google.com/search/docs/fundamentals/creating-helpful-content)
- [Google: URL migrations](https://developers.google.com/search/docs/crawling-indexing/site-move-with-url-changes)
- [Google: AI features](https://developers.google.com/search/docs/appearance/ai-features)

Recheck current official guidance when a task depends on a changing search feature.
