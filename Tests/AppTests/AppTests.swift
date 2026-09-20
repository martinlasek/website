@testable import App
import Foundation
import XCTVapor

final class AppTests: XCTestCase {
    func testPublicPagesRemainAvailable() async throws {
        try await withApplication { app in
            let paths = [
                "/", "/articles", "/about", "/projects", "/sponsorship",
                "/articles/error-app-intents-ssu-training",
                "/articles/get-size-of-view-in-swiftui",
                "/articles/list-and-identifiable-in-swiftui",
                "/articles/understanding-state-in-swiftui",
                "/articles/how-to-add-a-placeholder-to-texteditor",
                "/articles/how-to-fix-server-with-unspecified-hostname-not-found",
                "/articles/uihostingcontroller-and-safearea",
                "/apps/momoko/privacy-policy", "/apps/momoko/terms", "/apps/momoko/support"
            ]
            for path in paths {
                try await app.test(.GET, path) { response in
                    XCTAssertEqual(response.status, .ok, path)
                    XCTAssertTrue(response.body.string.contains("Martin Lasek"), path)
                    XCTAssertFalse(response.body.string.contains("Internal Error"), path)
                }
            }
            try await app.test(.HEAD, "/articles/error-app-intents-ssu-training") { response in
                XCTAssertEqual(response.status, .ok)
                XCTAssertEqual(response.headers.contentType, .html)
            }
        }
    }

    func testMissingPagesAndAssetsReturnHTML404() async throws {
        try await withApplication { app in
            for path in ["/missing-page", "/articles/missing-post", "/blog/missing-post", "/articles/missing.png"] {
                try await app.test(.GET, path) { response in
                    XCTAssertEqual(response.status, .notFound, path)
                    XCTAssertEqual(response.headers.contentType, .html)
                    XCTAssertTrue(response.body.string.contains("404 Not Found"))
                    XCTAssertTrue(response.body.string.contains("href=\"/\""))
                    XCTAssertFalse(response.body.string.contains("LeafError"))
                }
            }
        }
    }

    func testServerErrorsHideDetailsAndPreserveStatusHeaders() async throws {
        try await withApplication { app in
            app.get("test-internal-error") { _ -> String in
                throw NSError(domain: "private-database-detail", code: 1)
            }
            app.get("test-unavailable") { _ -> String in
                throw Abort(.serviceUnavailable, headers: ["Retry-After": "30"], reason: "private-service-detail")
            }
            try await app.test(.GET, "/test-internal-error") { response in
                XCTAssertEqual(response.status, .internalServerError)
                XCTAssertTrue(response.body.string.contains("500 Internal Server Error"))
                XCTAssertFalse(response.body.string.contains("private-database-detail"))
                XCTAssertEqual(response.headers.first(name: .cacheControl), "no-store")
            }
            try await app.test(.GET, "/test-unavailable") { response in
                XCTAssertEqual(response.status, .serviceUnavailable)
                XCTAssertEqual(response.headers.first(name: "Retry-After"), "30")
                XCTAssertFalse(response.body.string.contains("private-service-detail"))
            }
        }
    }

    func testExistingStaticFilesKeepTheirContentsAndTypes() async throws {
        try await withApplication { app in
            for (path, mimeType) in [
                ("/articles/007_the_solution.png", "image/png"),
                ("/articles/004_first_state_showcase.gif", "image/gif"),
                ("/styles/swift-syntax.css", "text/css")
            ] {
                let expected = try Data(contentsOf: URL(fileURLWithPath: app.directory.publicDirectory + String(path.dropFirst())))
                try await app.test(.GET, path) { response in
                    XCTAssertEqual(response.status, .ok, path)
                    XCTAssertTrue(response.headers.first(name: .contentType)?.hasPrefix(mimeType) == true, path)
                    XCTAssertEqual(Data(response.body.readableBytesView), expected, path)
                }
            }
        }
    }

    private func withApplication(_ test: (Application) async throws -> Void) async throws {
        let app = try await Application.make(.testing)
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
