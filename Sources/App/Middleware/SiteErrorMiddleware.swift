import HtmlVaporSupport
import Vapor

struct SiteErrorMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        next.respond(to: request).flatMapErrorThrowing { error in
            let abort = error as? AbortError
            let status = abort?.status ?? .internalServerError
            if status.code >= 500 {
                request.logger.report(error: error)
            }

            let title = "\(status.code) \(status.reasonPhrase)"
            let message = status == .notFound
                ? "The page you requested could not be found."
                : "We couldn't complete your request. Please try again later."
            let page = Node.document(
                .html(attributes: [.lang(.en)],
                    .head(
                        .title(title),
                        .meta(attributes: [.charset("utf-8")]),
                        .meta(name: "viewport", content: "width=device-width, initial-scale=1")
                    ),
                    .body(
                        .main(
                            .h1(.text(title)),
                            .p(.text(message)),
                            .a(attributes: [.href("/")], "Return to Martin Lasek's website")
                        )
                    )
                )
            )

            var headers = abort?.headers ?? HTTPHeaders()
            headers.contentType = .html
            headers.replaceOrAdd(name: .cacheControl, value: "no-store")
            headers.remove(name: .contentLength)
            return Response(status: status, headers: headers, body: .init(string: Html.render(page)))
        }
    }
}
