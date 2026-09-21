import HtmlVaporSupport

struct AppCard {
    let name: String
    let summary: String?
    let platform: String?
    let iconPath: String?
    let destination: SiteLink?

    init(name: String, summary: String? = nil, platform: String? = nil,
         iconPath: String? = nil, destination: SiteLink? = nil) {
        self.name = name
        self.summary = summary
        self.platform = platform
        self.iconPath = iconPath
        self.destination = destination
    }

    var content: Node {
        let icon: Node
        if let iconPath {
            precondition(SiteURL.isValidPath(iconPath), "App icon must use a local asset")
            icon = .img(src: iconPath, alt: "", attributes: [.class("site-app-icon"), .init("width", "72"), .init("height", "72"), .init("loading", "lazy")])
        } else {
            icon = .div(attributes: [.class("site-product-monogram"), .init("aria-hidden", "true")], .text(String(name.prefix(1))))
        }
        let contents: Node = .fragment([
            icon,
            .h3(.text(name)),
            .fragment(summary.map { [.p(.text($0))] } ?? []),
            .fragment(platform.map { [.span(attributes: [.class("site-tag")], .text($0))] } ?? [])
        ])
        let body: Node
        if let destination {
            body = .a(attributes: [.class("site-app-link"), .href(Html.escapeTextNode(text: destination.destination)),
                                   .init("aria-label", Html.escapeTextNode(text: name))], contents)
        } else {
            body = .div(attributes: [.class("site-app-link")], contents)
        }
        return .article(attributes: [.class("site-app-card")], body)
    }
}
