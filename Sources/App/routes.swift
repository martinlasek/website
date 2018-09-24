import Vapor

public func routes(_ router: Router) throws {
    router.get { req in
        return try req.view().render("index", Route.Active.index)
    }
}
