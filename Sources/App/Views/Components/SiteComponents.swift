import HtmlVaporSupport

enum SiteComponents {
    static func button(_ link: SiteLink, hasDarkBackground: Bool = false) -> Node {
        .a(attributes: [
            .href(Html.escapeTextNode(text: link.destination)),
            .class(hasDarkBackground ? "site-button site-button-ghost" : "site-button")
        ] + LinkAttributes.externalNavigation(for: link.destination), .text(link.title))
    }

    static func heading(eyebrow: String, title: String, summary: String) -> Node {
        .div(attributes: [.class("site-page-heading")],
            .p(attributes: [.class("site-eyebrow")], .text(eyebrow)),
            .h1(.text(title)),
            .p(.text(summary))
        )
    }

    static func postGrid(_ cards: [PostCard]) -> Node {
        .div(attributes: [.class("site-post-grid")], .fragment(cards.map { $0.content }))
    }

    static func appGrid(_ cards: [AppCard]) -> Node {
        .div(attributes: [.class("site-app-grid")], .fragment(cards.map { $0.content }))
    }
}
