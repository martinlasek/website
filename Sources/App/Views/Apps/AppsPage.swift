import HtmlVaporSupport

enum AppsPage {
    static func content(shouldTrackAnalytics: Bool) -> Node {
        PublicSite.page(metadata: PageMetadata(canonicalPath: "/apps", headline: "Apps & Projects | Martin Lasek",
                                              subheadline: "Apps and projects by Martin Lasek."),
                        shouldTrackAnalytics: shouldTrackAnalytics,
                        content: .div(attributes: [.class("site-wrap site-archive")],
                            SiteComponents.heading(eyebrow: "Made by Martin", title: "Apps & projects", summary: "A mix of games, productivity tools, and developer tools."),
                            PublicSite.products))
    }
}
