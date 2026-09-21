import HtmlVaporSupport

enum ProjectPage {
    static func content(_ project: Project, shouldTrackAnalytics: Bool) -> Node {
        PublicSite.page(
            metadata: PageMetadata(canonicalPath: project.canonicalPath,
                                   headline: "\(project.name) | Martin Lasek", subheadline: project.summary),
            shouldTrackAnalytics: shouldTrackAnalytics,
            content: .div(attributes: [.class("site-wrap site-archive")],
                .p(.a(attributes: [.href("/projects")], "← All projects")),
                SiteComponents.heading(eyebrow: project.category, title: project.name, summary: project.summary),
                .div(attributes: [.class("site-about-layout")],
                    .div(attributes: [.class("site-prose")],
                        .h2("About the project"),
                        .p(.text(project.overview)),
                        .h2("Highlights"),
                        .ul(.fragment(project.highlights.map { .li(.text($0)) })),
                        .div(attributes: [.class("site-actions")],
                            .fragment(project.links.map { SiteComponents.button($0) }))
                    ),
                    .aside(attributes: [.class("site-info-panel")],
                        .h2("More projects"),
                        .ul(.fragment(ProjectCatalog.all.filter { $0.slug != project.slug }.map {
                            .li(.a(attributes: [.href($0.canonicalPath)], .text($0.name)))
                        }))
                    )
                )
            )
        )
    }
}
