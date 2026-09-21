import Foundation
import HtmlVaporSupport

enum SiteLayout {
    static let stylesheet = "/styles/site-v4.css"

    /// Callers supply only destinations that are ready to launch.
    static func page(
        metadata: MetaTagProvider,
        navigation: [SiteLink],
        footerLinks: [SiteLink],
        currentPath: String,
        shouldTrackAnalytics: Bool = false,
        isPreview: Bool = false,
        hasHeroBackdrop: Bool = false,
        hasSwiftCode: Bool = false,
        headContent: ChildOf<Tag.Head> = .fragment([]),
        content: Node
    ) -> Node {
        .html(attributes: [.lang(.en)],
            .head(
                PageBuilder.metadata(metadata),
                headContent,
                .link(attributes: [.rel(.stylesheet), .href(stylesheet)]),
                isPreview ? .meta(name: "robots", content: "noindex,nofollow") : .fragment([])
            ),
            .body(attributes: [.class(hasHeroBackdrop ? "site site-home" : "site")],
                .a(attributes: [.href("#main"), .class("site-skip")], "Skip to content"),
                header(navigation: navigation, currentPath: currentPath),
                .main(attributes: [.id("main")], content),
                footer(links: footerLinks),
                hasSwiftCode ? .raw("""
                <script defer data-manual src="/scripts/prism-1.30.0/prism-core.min.js"></script>
                <script defer src="/scripts/prism-1.30.0/prism-swift.min.js"></script>
                <script defer src="/scripts/prism-1.30.0/highlight-swift.js"></script>
                """) : .fragment([]),
                Analytics.scripts(isEnabled: shouldTrackAnalytics && !isPreview)
            )
        )
    }

    private static func links(_ links: [SiteLink], currentPath: String) -> Node {
        .fragment(links.map { link in
            var attributes: [Attribute<Tag.A>] = [.href(Html.escapeTextNode(text: link.destination))]
            if link.destination == currentPath { attributes.append(.init("aria-current", "page")) }
            return .a(attributes: attributes, .text(link.title))
        })
    }

    private static func header(navigation: [SiteLink], currentPath: String) -> Node {
        .header(attributes: [.class("site-header")],
            .div(attributes: [.class("site-wrap site-header-inner")],
                .a(attributes: [.href("/"), .class("site-brand")], "Martin Lasek"),
                .nav(attributes: [.class("site-desktop-nav"), .init("aria-label", "Main")],
                    links(navigation, currentPath: currentPath)),
                .div(attributes: [.class("site-contact")],
                    SocialLinks.content),
                .details(attributes: [.class("site-mobile-nav")], .summary("Menu"),
                    .nav(attributes: [.init("aria-label", "Mobile")],
                        links(navigation, currentPath: currentPath),
                        SocialLinks.content
                    )
                )
            )
        )
    }

    private static func footer(links footerLinks: [SiteLink]) -> Node {
        .footer(attributes: [.class("site-footer")],
            .div(attributes: [.class("site-wrap site-footer-inner")],
                .div(
                    .a(attributes: [.href("/"), .class("site-brand")], "Martin Lasek"),
                    .p("iOS developer · Indie maker")
                ),
                .nav(attributes: [.init("aria-label", "Footer")],
                    links(footerLinks, currentPath: ""),
                    SocialLinks.content
                ),
                .p(.text("© \(Calendar.current.component(.year, from: Date())) Martin Lasek"))
            )
        )
    }
}
