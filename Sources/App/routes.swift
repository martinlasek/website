import Vapor
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {

    for page in MomokoPages.all {
        app.get("apps", "\(page.appSlug)", "\(page.slug)") { _ -> Node in
            page.content
        }
    }

    // MARK: - Index

    app.get(use: getIndex)
    app.get("\(NavLink.articles.href)", use: getIndex)

    // MARK: - Article Detail Papges

    try Article.register(Article.all, on: app)

    // MARK: - Projects

    app.get("\(NavLink.projects.href)") { req throws -> Node in
        PageBuilder.base(navLink: .projects) {
            .h1(attributes: [.class("text-center")], "Coming Soon")
        }
    }

    // MARK: - Sponsorship

    app.get("\(NavLink.sponsorship.href)") { req throws -> Node in
        SponsorshipPage.content
    }

    // MARK: - About

    app.get("\(NavLink.about.href)") { req throws -> Node in
        AboutPage.content
    }

    func getIndex(_ req: Request) throws -> Node {
        PageBuilder.base(navLink: NavLink.articles) {
            .fragment(Article.all.map(Article.excerpt))
        }
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
