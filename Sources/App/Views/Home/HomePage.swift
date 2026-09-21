import HtmlVaporSupport

enum HomePage {
    static func content(shouldTrackAnalytics: Bool) -> Node {
        PublicSite.page(
            metadata: PageMetadata(canonicalPath: "/", headline: "Martin Lasek | Apps, Swift & iOS Development",
                                   subheadline: "Apps, games, and practical Swift tutorials by Martin Lasek."),
            shouldTrackAnalytics: shouldTrackAnalytics,
            content: .fragment([
                .section(attributes: [.class("site-hero")],
                    .div(attributes: [.class("site-wrap site-hero-inner")],
                        .p(attributes: [.class("site-eyebrow")], "Building apps for a more playful, useful world"),
                        .h1("Hi, I'm ", .span("Martin.")),
                        .p("I'm an iOS developer with a passion for building apps and games. I enjoy turning ideas into useful products and sharing what I learn along the way."),
                        .div(attributes: [.class("site-actions")],
                            SiteComponents.button(SiteLink(title: "See my apps →", destination: "/apps")),
                            SiteComponents.button(SiteLink(title: "Read the blog", destination: "/blog"), hasDarkBackground: true))
                    )),
                .section(attributes: [.class("site-section")],
                    .div(attributes: [.class("site-wrap")],
                        .div(attributes: [.class("site-section-heading")],
                            .div(.p(attributes: [.class("site-eyebrow")], "Featured apps"), .h2("Apps I'm Building")),
                            SiteComponents.button(SiteLink(title: "View all apps →", destination: "/apps"))),
                        PublicSite.products)),
                .section(attributes: [.class("site-section site-tinted")],
                    .div(attributes: [.class("site-wrap")],
                        .div(attributes: [.class("site-section-heading")],
                            .div(.p(attributes: [.class("site-eyebrow")], "Latest posts"), .h2("Thoughts & Learnings")),
                            SiteComponents.button(SiteLink(title: "View all posts →", destination: "/blog"))),
                        PublicSite.postCards(Array(PublicSite.posts.prefix(3)))))
            ])
        )
    }
}
