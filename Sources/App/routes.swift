import Vapor
import Leaf
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {
    app.get { req throws -> Response in
        return req.redirect(to: NavLink.tutorials.href)
    }

    app.get("\(NavLink.tutorials.href)") { req throws -> Node in
        PageBuilder.base(canonUrlPath: "tutorials") {
            .fragment(Article.all.map(Article.excerpt))
        }
    }
}
