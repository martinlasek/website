import HtmlVaporSupport

enum PublicSite {
    static let navigation = [
        SiteLink(title: "Apps", destination: "/apps"),
        SiteLink(title: "Blog", destination: "/blog"),
        SiteLink(title: "About", destination: "/about")
    ]

    static func page(metadata: PageMetadata, shouldTrackAnalytics: Bool, content: Node) -> Node {
        SiteLayout.page(metadata: metadata, navigation: navigation,
                        footerLinks: navigation + [SiteLink(title: "Sponsor", destination: "/sponsorship")],
                        currentPath: metadata.canonicalPath, shouldTrackAnalytics: shouldTrackAnalytics, content: content)
    }

    static var posts: [Article] {
        Article.all.sorted { $0.dateForSitemap > $1.dateForSitemap }
    }

    static func postCards(_ articles: [Article]) -> Node {
        SiteComponents.postGrid(articles.map { PostCard(article: $0, cover: $0.cover!) })
    }

    static var products: Node {
        .div(attributes: [.class("site-app-grid")],
            .fragment(["Momoko", "WishKit", "PostBurst", "ReadMarkdown", "Bilingual Subtitles"].map { name in
                let contents: Node = .fragment([
                    .div(attributes: [.class("site-product-monogram"), .init("aria-hidden", "true")], .text(String(name.prefix(1)))),
                    .h3(.text(name)),
                    name == "WishKit" ? .p("Collect feature requests and feedback inside your app.") : .fragment([])
                ])
                return .article(attributes: [.class("site-app-card")],
                    name == "WishKit"
                        ? .a(attributes: [.class("site-app-link"), .href("https://www.wishkit.io/")], contents)
                        : .div(attributes: [.class("site-app-link")], contents)
                )
            })
        )
    }
}
