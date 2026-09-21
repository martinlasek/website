import HtmlVaporSupport

struct PostCard {
    let article: Article
    let cover: ArticleCover

    init(article: Article, cover: ArticleCover) {
        precondition(SiteURL.isValidPath(cover.path) && cover.width > 0 && cover.height > 0, "Invalid post cover")
        self.article = article
        self.cover = cover
    }

    var content: Node {
        .article(attributes: [.class("site-post-card")],
            .a(attributes: [.class("site-post-link"), .href(article.canonicalPath),
                            .init("aria-label", Html.escapeTextNode(text: article.headline))],
                .img(src: cover.path, alt: "", attributes: [
                    .class("site-post-cover"), .init("width", String(cover.width)),
                    .init("height", String(cover.height)), .init("loading", "lazy")
                ]),
                .div(attributes: [.class("site-post-content")],
                    .div(attributes: [.class("site-post-meta")],
                        .fragment(article.category.map { [.span(.text($0)), separator] } ?? []),
                        .time(attributes: [.init("datetime", article.dateForSitemap)], .text(article.published_at.readableFormat)),
                        separator,
                        .span(attributes: [.init("aria-label", "Estimated reading time: \(article.readingMinutes) minutes")],
                              .text("\(article.readingMinutes) min read"))
                    ),
                    .h3(.text(article.headline)),
                    .p(.text(article.subheadline))
                )
            )
        )
    }

    private var separator: Node { .span(attributes: [.init("aria-hidden", "true")], "·") }
}
