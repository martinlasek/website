import Vapor
import Leaf
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {

    // MARK: - Index

    app.get(use: getIndex)
    app.get("\(NavLink.articles.href)", use: getIndex)

    // MARK: - Article Detail Papges
    for article in Article.all {
        app.get("\(NavLink.articles.href)", "\(article.slug)") { req throws -> Node in
            PageBuilder.base(navLink: .articles, article.node)
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

    func getIndex(_ req: Request) throws -> Node {
        PageBuilder.base(navLink: NavLink.articles) {
            .fragment(Article.all.map(Article.excerpt))
        }
    }
}
