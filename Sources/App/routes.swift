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
            PageBuilder.base(navLink: .articles, meta: article, Article.layout(for: article))
        }
    }

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

    // MARK: - Sitemap

    app.get("sitemap") { req throws -> Node in
        return .raw("""
            <?xml version="1.0" encoding="UTF-8"?>
            <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
                <url>
                    <loc>https://www.martinlasek.com/about</loc>
                    <lastmod>2023-10-10</lastmod>
                </url>
                <url>
                    <loc>https://www.martinlasek.com/sponsorship</loc>
                    <lastmod>2023-10-10</lastmod>
                </url>
                <url>
                    <loc>https://www.martinlasek.com/projects</loc>
                    <lastmod>2023-10-10</lastmod>
                </url>
                \(Article.all.map({ article in
                    """
                    <url>
                        <loc>https://www.martinlasek.com/articles/\(article.slug)</loc>
                        <lastmod>\(article.dateForSitemap)</lastmod>
                    </url>
                    """
                }).joined())
            </urlset>
        """)
    }
}
