import Vapor
import Leaf
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {
    app.get { req throws -> Response in
        return req.redirect(to: NavLink.tutorials.href)
    }

    app.get("\(NavLink.tutorials.href)") { req throws -> Node in
        PageBuilder.base(navLink: NavLink.tutorials) {
            .fragment(Article.all.map(Article.excerpt))
        }
    }

    for article in Article.all {
        app.get("\(NavLink.tutorials.href)", "\(article.slug)") { req throws -> Node in
            PageBuilder.base(navLink: .tutorials, article.node)
        }
    }

    app.get("\(NavLink.projects.href)") { req throws -> Node in
        PageBuilder.base(navLink: .projects) {
            .h1(attributes: [.class("text-center")], "Coming Soon")
        }
    }

    app.get("\(NavLink.sponsorship.href)") { req throws -> Node in
        SponsorshipPage.content
    }

    app.get("\(NavLink.about.href)") { req throws -> Node in
        AboutPage.content
    }
}
