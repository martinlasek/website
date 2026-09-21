import HtmlVaporSupport

enum ProjectsPage {
    static func content(shouldTrackAnalytics: Bool) -> Node {
        PublicSite.page(
            metadata: PageMetadata(canonicalPath: "/projects", headline: "Projects | Martin Lasek",
                                   subheadline: "Apps, games, SaaS, and developer tools by Martin Lasek."),
            shouldTrackAnalytics: shouldTrackAnalytics,
            content: .div(attributes: [.class("site-wrap site-archive")],
                SiteComponents.heading(eyebrow: "Made by Martin", title: "Projects",
                                       summary: "A mix of apps, games, SaaS, and developer tools."),
                PublicSite.products)
        )
    }
}
