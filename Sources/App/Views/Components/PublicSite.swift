import HtmlVaporSupport

enum PublicSite {
    static let navigation = [
        SiteLink(title: "Projects", destination: "/projects"),
        SiteLink(title: "Blog", destination: "/blog"),
        SiteLink(title: "About", destination: "/about")
    ]

    static func page(metadata: PageMetadata, shouldTrackAnalytics: Bool, content: Node) -> Node {
        SiteLayout.page(metadata: metadata, navigation: navigation,
                        footerLinks: navigation + [SiteLink(title: "Sponsor", destination: "/sponsor")],
                        currentPath: metadata.canonicalPath, shouldTrackAnalytics: shouldTrackAnalytics, hasHeroBackdrop: metadata.canonicalPath == "/", content: content)
    }

    static var posts: [Article] {
        Article.all.sorted { $0.dateForSitemap > $1.dateForSitemap }
    }

    static func postCards(_ articles: [Article]) -> Node {
        SiteComponents.postGrid(articles.map { PostCard(article: $0, cover: $0.cover!) })
    }

    static var products: Node {
        SiteComponents.appGrid(ProjectCatalog.cards)
    }
}
