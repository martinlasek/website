import HtmlVaporSupport

struct AboutPage {
    static func content(shouldTrackAnalytics: Bool = false) -> Node {
        PublicSite.page(
            metadata: PageMetadata(
                canonicalPath: "/about",
                headline: "About Martin Lasek | iOS Developer & Indie Maker",
                subheadline: "Meet Martin Lasek, an iOS developer and indie maker building apps, games, and practical Swift tutorials."
            ),
            shouldTrackAnalytics: shouldTrackAnalytics,
            content: .div(attributes: [.class("site-wrap site-archive")],
                SiteComponents.heading(
                    eyebrow: "A little about me", title: "Hi, I'm Martin.",
                    summary: "iOS developer. Indie maker. Always learning."
                ),
                .div(attributes: [.class("site-about-layout")],
                    .div(attributes: [.class("site-prose")],
                        .p("I build apps and games, and write about what I learn along the way."),
                        .p("I enjoy taking a new idea, working through the details, and turning it into something useful or fun. My projects range from developer tools to games and everyday Mac utilities."),
                        .p("On this blog, I share practical Swift tutorials, project stories, and lessons from building my own products. I aim to make the technical details clear enough that you can use them in your own work."),
                        .p("Have a question about a post or one of my apps? Find me on social media."),
                        .div(attributes: [.class("site-actions")],
                            SocialLinks.content)
                    ),
                    .aside(attributes: [.class("site-info-panel")],
                        .h2("Explore my work"),
                        .ul(
                            .li(.a(attributes: [.href("/projects")], "Projects")),
                            .li(.a(attributes: [.href("/blog")], "Swift tutorials & writing")),
                            .li(.a(attributes: [.href("/sponsor")], "Sponsor my writing"))
                        )
                    )
                )
            )
        )
    }
}
