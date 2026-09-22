import Vapor

struct HTTPSRedirectMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        // Heroku terminates TLS before forwarding requests to the app.
        // Only a definite HTTP value triggers a redirect, avoiding HTTPS loops.
        let host = request.headers.first(name: .host)?.lowercased()
        guard request.application.environment == .production,
              host == "www.martinlasek.com" || host == "www.martinlasek.com:80",
              request.headers["X-Forwarded-Proto"] == ["http"] else {
            return next.respond(to: request)
        }

        let path = request.url.path.isEmpty ? "/" : request.url.path
        let query = request.url.query.map { "?\($0)" } ?? ""
        // A fixed origin prevents request headers from controlling the destination.
        let location = "\(SiteURL.origin)\(path)\(query)"
        let response = Response(status: .permanentRedirect, headers: ["Location": location])
        return request.eventLoop.makeSucceededFuture(response)
    }
}
