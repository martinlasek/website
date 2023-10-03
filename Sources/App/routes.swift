import Vapor
import Leaf
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {
    app.get { req throws -> Node in
        PageBuilder.base {
            Node.p("It's dangerous to go alone, take this!")
        }
    }
}




