import HtmlVaporSupport

enum DetailHero {
    static func content(title: String, summary: String, backLink: SiteLink, artwork: Node, details: Node) -> Node {
        .section(attributes: [.class("site-hero site-detail-hero")],
            .div(attributes: [.class("site-detail-art")], artwork),
            .div(attributes: [.class("site-wrap site-hero-inner")],
                .a(attributes: [.href(backLink.destination), .class("site-detail-back")], .text(backLink.title)),
                .h1(.text(title)),
                .p(.text(summary)),
                details
            )
        )
    }
}
