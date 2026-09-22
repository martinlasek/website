@testable import App
import XCTVapor

final class HTTPSRedirectTests: XCTestCase {
    func testHTTPRedirectPreservesPathsQueriesAndMethods() async throws {
        try await withApplication(.production) { app in
            let paths = [
                "/", "/blog", "/sitemap.xml", "/robots.txt", "/styles/site-v6.css",
                "/articles/error-app-intents-ssu-training?utm_source=launch-check",
                "/missing%20page?tag=one&tag=two&next=%2Fblog%3Fx%3D1&text=a+b",
                "/blog?"
            ]
            for method in [HTTPMethod.GET, .HEAD, .POST] {
                for path in paths {
                    try await app.test(method, path, headers: [
                        "Host": "www.martinlasek.com", "X-Forwarded-Proto": "http"
                    ]) { response in
                        XCTAssertEqual(response.status, .permanentRedirect, path)
                        XCTAssertEqual(response.headers.first(name: .location), "https://www.martinlasek.com\(path)")
                    }
                }
            }
            try await app.test(.GET, "/blog", headers: [
                "Host": "WWW.MARTINLASEK.COM:80", "X-Forwarded-Proto": "http"
            ]) { response in
                XCTAssertEqual(response.status, .permanentRedirect)
                XCTAssertEqual(response.headers.first(name: .location), "https://www.martinlasek.com/blog")
            }
        }
    }

    func testHTTPSAndUnknownProxyHeadersDoNotLoopOrChangeErrors() async throws {
        try await withApplication(.production) { app in
            for protocols in [[], ["https"], ["http, https"], ["http", "https"]] as [[String]] {
                var headers: HTTPHeaders = ["Host": "www.martinlasek.com"]
                for value in protocols {
                    headers.add(name: "X-Forwarded-Proto", value: value)
                }
                for (path, status) in [("/blog", HTTPStatus.ok), ("/missing-page", .notFound)] {
                    try await app.test(.GET, path, headers: headers) { response in
                        XCTAssertEqual(response.status, status)
                        XCTAssertNil(response.headers.first(name: .location))
                    }
                }
            }
            for host in ["localhost:8080", "martinlasek.herokuapp.com", "www.martinlasek.de", "unrelated.example"] {
                try await app.test(.GET, "/blog", headers: ["Host": host, "X-Forwarded-Proto": "http"]) { response in
                    XCTAssertEqual(response.status, .ok)
                    XCTAssertNil(response.headers.first(name: .location))
                }
            }
        }
    }

    func testLocalEnvironmentsKeepHTTPAvailable() async throws {
        for environment in [Environment.development, .testing] {
            try await withApplication(environment) { app in
                try await app.test(.GET, "/blog", headers: [
                    "Host": "www.martinlasek.com", "X-Forwarded-Proto": "http"
                ]) { response in
                    XCTAssertEqual(response.status, .ok)
                    XCTAssertNil(response.headers.first(name: .location))
                }
            }
        }
    }

    private func withApplication(
        _ environment: Environment,
        test: (Application) async throws -> Void
    ) async throws {
        let app = try await Application.make(environment)
        do {
            try await configure(app)
            try await test(app)
        } catch {
            try await app.asyncShutdown()
            throw error
        }
        try await app.asyncShutdown()
    }
}
