import HtmlVaporSupport

enum ProjectPage {
    static func content(_ project: Project, shouldTrackAnalytics: Bool) -> Node {
        PublicSite.page(
            metadata: PageMetadata(canonicalPath: project.canonicalPath,
                                   headline: "\(project.name) | Martin Lasek", subheadline: project.summary),
            shouldTrackAnalytics: shouldTrackAnalytics,
            content: .div(attributes: [.class("site-wrap site-archive site-project-detail")],
                .p(.a(attributes: [.href("/projects")], "← All projects")),
                hero(project),
                .div(attributes: [.class("site-project-title")],
                    .h1(.text(project.name)),
                    project.links.first.map { link in
                        .a(attributes: [.href(link.destination)], .text(link.title))
                    } ?? .fragment([])
                ),
                .p(attributes: [.class("site-project-summary")], .text(project.summary)),
                .div(attributes: [.class("site-project-body")],
                    .div(attributes: [.class("site-prose")],
                        .h2("About the project"),
                        .p(.text(project.overview)),
                        .h2("Highlights"),
                        .ul(.fragment(project.highlights.map { .li(.text($0)) })),
                        .div(attributes: [.class("site-actions")],
                            .fragment(project.links.dropFirst().map { SiteComponents.button($0) }))
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

    private static func hero(_ project: Project) -> Node {
        if let path = project.heroImagePath {
            return .div(attributes: [.class("site-project-hero")],
                .img(src: path, alt: project.heroImageAlt, attributes: [
                    .class("site-project-hero-image"), .init("fetchpriority", "high")
                ]))
        }
        return .div(attributes: [.class("site-project-hero site-project-hero-\(project.slug)"), .init("aria-hidden", "true")],
            project.iconPath.map {
                .img(src: $0, alt: "", attributes: [.class("site-project-hero-icon"), .init("width", "144"), .init("height", "144")])
            } ?? .fragment([]))
    }
}
