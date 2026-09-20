import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) async throws {

    // MARK: - Middleware

    app.middleware.use(SiteErrorMiddleware())
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // MARK: - Leaf

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
