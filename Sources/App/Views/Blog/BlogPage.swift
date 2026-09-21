import HtmlVaporSupport

enum BlogPage {
    static func content(shouldTrackAnalytics: Bool) -> Node {
        PublicSite.page(metadata: PageMetadata(canonicalPath: "/blog", headline: "Blog | Martin Lasek",
                                              subheadline: "Practical Swift tutorials, project stories, and lessons from building apps."),
                        shouldTrackAnalytics: shouldTrackAnalytics,
                        content: .div(attributes: [.class("site-wrap site-archive")],
                            SiteComponents.heading(eyebrow: "Writing & tutorials", title: "Blog", summary: "Practical Swift tutorials, project stories, and lessons from building apps."),
                            PublicSite.postCards(PublicSite.posts)))
    }
}
