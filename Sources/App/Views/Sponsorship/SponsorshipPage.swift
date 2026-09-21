import HtmlVaporSupport

struct SponsorshipPage {
    static func content(shouldTrackAnalytics: Bool = false) -> Node {
        PublicSite.page(
            metadata: PageMetadata(
                canonicalPath: "/sponsor",
                headline: "Sponsor | Martin Lasek",
                subheadline: "Interested in sponsoring Martin Lasek's writing? Get in touch to discuss your product, placement, and preferred dates."
            ),
            shouldTrackAnalytics: shouldTrackAnalytics,
            content: .div(attributes: [.class("site-wrap site-archive")],
                SiteComponents.heading(
                    eyebrow: "Work together", title: "Sponsor my writing.",
                    summary: "Interested in featuring your product alongside my articles?"
                ),
                .div(attributes: [.class("site-about-layout")],
                    .div(attributes: [.class("site-prose")],
                        .p("I write about Swift, iOS development, and the things I learn while building apps. If your product could be useful to readers, I'd love to hear about it."),
                        .p("Connect with me on X to discuss your product and potential sponsorship."),
                        .div(attributes: [.class("site-actions")],
                            SiteComponents.button(SiteLink(title: "Find me on X ↗", destination: "https://twitter.com/martinlasek")))
                    ),
                    .aside(attributes: [.class("site-info-panel")],
                        .h2("Start a conversation"),
                        .p("Share a little about your product, who it's for, and your preferred dates. We can discuss placement and availability from there."))
                )
            )
        )
    }
}
