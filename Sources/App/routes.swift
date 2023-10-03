import Vapor
import Leaf
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {
    app.get { req throws -> Node in
        IndexPage.create(with: Article.latest)
    }
}
