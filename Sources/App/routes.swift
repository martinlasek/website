import Vapor
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {

    for page in MomokoPages.all {
        app.get("apps", "\(page.appSlug)", "\(page.slug)") { _ -> Node in
            page.content
        }
    }

    // MARK: - Index

    app.get { request -> Node in
        HomePage.content(shouldTrackAnalytics: request.application.environment == .production)
    }
    app.get("blog") { request -> Node in
        BlogPage.content(shouldTrackAnalytics: request.application.environment == .production)
    }
    // Serve an alias: reversing the previously shipped /projects redirect could create cached loops.
    app.get("apps") { request -> Node in
        ProjectsPage.content(shouldTrackAnalytics: request.application.environment == .production)
    }
    app.get("articles") { request in request.redirect(to: "/blog", redirectType: .permanent) }

    // MARK: - Article Detail Papges

    try Article.register(Article.all, on: app)

    // MARK: - Projects

    app.get("projects") { request -> Node in
        ProjectsPage.content(shouldTrackAnalytics: request.application.environment == .production)
    }
    for project in ProjectCatalog.all {
        app.get("projects", "\(project.slug)") { request -> Node in
            ProjectPage.content(project, shouldTrackAnalytics: request.application.environment == .production)
        }
    }

    // MARK: - Sponsorship

    app.get("sponsorship") { request in request.redirect(to: "/sponsor", redirectType: .permanent) }

    app.get("\(NavLink.sponsorship.href)") { req throws -> Node in
        SponsorshipPage.content(shouldTrackAnalytics: req.application.environment == .production)
    }

    // MARK: - About

    app.get("\(NavLink.about.href)") { req throws -> Node in
        AboutPage.content(shouldTrackAnalytics: req.application.environment == .production)
    }

    // MARK: - Search discovery

    app.get("sitemap.xml") { _ -> Response in
        Sitemap.response()
    }

    app.get("sitemap") { _ -> Response in
        Sitemap.response()
    }

    app.get("robots.txt") { _ -> Response in
        Response(
            headers: ["Content-Type": "text/plain; charset=utf-8"],
            body: .init(string: "User-agent: *\nAllow: /\nSitemap: \(Sitemap.siteURL)/sitemap.xml\n")
        )
    }
}
