import HtmlVaporSupport

struct AppCard {
    let name: String
    let summary: String
    let platform: String
    let iconPath: String
    let destination: SiteLink

    var content: Node {
        precondition(SiteURL.isValidPath(iconPath), "App icon must use a local asset")
        return .article(attributes: [.class("site-app-card")],
            .a(attributes: [.class("site-app-link"), .href(Html.escapeTextNode(text: destination.destination)),
                            .init("aria-label", Html.escapeTextNode(text: name))],
                .img(src: iconPath, alt: "", attributes: [.class("site-app-icon"), .init("width", "72"), .init("height", "72"), .init("loading", "lazy")]),
                .h3(.text(name)),
                .p(.text(summary)),
                .span(attributes: [.class("site-tag")], .text(platform))
            )
        )
    }
}
