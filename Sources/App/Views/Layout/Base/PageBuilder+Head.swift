import HtmlVaporSupport

extension PageBuilder {
    /// Metadata only: safe to reuse on script-free app-information pages.
    static func metadata(_ meta: MetaTagProvider) -> ChildOf<Tag.Head> {
        // swift-html escapes quotes in attributes but not ampersands.
        let title = Html.escapeTextNode(text: meta.headline)
        let description = Html.escapeTextNode(text: meta.subheadline)
        var tags: [ChildOf<Tag.Head>] = [
            .meta(attributes: [.charset("utf-8")]),
            .meta(name: "viewport", content: "width=device-width, initial-scale=1"),
            .link(attributes: [.rel(.init(rawValue: "icon")), .href("/images/site/favicon-v1.svg"), .init("type", "image/svg+xml")]),
            .link(attributes: [.rel(.init(rawValue: "icon")), .href("/images/site/favicon-32-v1.png"), .init("sizes", "32x32"), .init("type", "image/png")]),
            .link(attributes: [.rel(.init(rawValue: "apple-touch-icon")), .href("/images/site/apple-touch-icon-v1.png")]),
            .init(.element("title", [], [.text(meta.headline)])),
            .meta(name: "description", content: description),
            .link(attributes: [.href(meta.fullCanonUrl), .rel(.init(rawValue: "canonical"))]),
            .meta(name: "twitter:card", content: meta.fullImageUrl == nil ? "summary" : "summary_large_image"),
            .meta(name: "twitter:title", content: title),
            .meta(name: "twitter:description", content: description),
            .meta(name: "twitter:site", content: "@martinlasek"),
            .meta(name: "twitter:creator", content: "@martinlasek"),
            .meta(property: "og:type", content: meta.openGraphType),
            .meta(property: "og:title", content: title),
            .meta(property: "og:description", content: description),
            .meta(property: "og:url", content: meta.fullCanonUrl)
        ]
        if let imageURL = meta.fullImageUrl {
            tags.append(.meta(name: "twitter:image", content: imageURL))
            tags.append(.meta(property: "og:image", content: imageURL))
            if let alt = meta.imageAlt {
                tags.append(.meta(name: "twitter:image:alt", content: Html.escapeTextNode(text: alt)))
                tags.append(.meta(property: "og:image:alt", content: Html.escapeTextNode(text: alt)))
            }
        }
        return .fragment(tags)
    }

    static func head(_ meta: MetaTagProvider) -> ChildOf<Tag.Html> {
        .head(
            metadata(meta),
            // MARK: - CDN

            .init(.raw("<!-- CDN -->")),
            .link(attributes: [
                .href("https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"),
                .rel(.stylesheet),
                .init("integrity", "sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"),
                .init("crossorigin", "anonymous")
            ]),

            .link(attributes: [
                .href("https://fonts.googleapis.com/css2?family=Roboto:wght@300;500;900&display=swap"),
                .rel(.stylesheet)
            ]),

            .link(attributes: [
                .href("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"),
                .rel(.stylesheet)
            ]),

            // MARK:  - CUSTOM

            .init(.raw("<!-- CSS -->")),
            .link(attributes: [
                .href("/styles/main-09-24-2024.css"),
                .rel(.stylesheet)
            ]),

            .link(attributes: [
                .href("/styles/swift-syntax.css"),
                .rel(.stylesheet)
            ])
        )
    }
}
