import Vapor
import Leaf
import LeafErrorMiddleware

// configures your application
public func configure(_ app: Application) async throws {

    // MARK: - Middleware

    app.middleware.use(LeafErrorMiddlewareDefaultGenerator.build())
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // MARK: - Leaf

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
