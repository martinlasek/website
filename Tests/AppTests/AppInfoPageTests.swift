@testable import App
import XCTVapor

final class AppInfoPageTests: XCTestCase {
    func testMomokoPages() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try routes(app)

        for slug in ["privacy-policy", "terms", "support"] {
            try app.test(.GET, "apps/momoko/\(slug)") { response in
                XCTAssertEqual(response.status, .ok)
                let html = response.body.string
                XCTAssertTrue(html.contains("https://www.martinlasek.com/apps/momoko/\(slug)"))
                XCTAssertTrue(html.contains("mailto:heylasek@gmail.com"))
                XCTAssertTrue(html.contains("width=device-width"))
                XCTAssertFalse(html.contains("<script"))
                XCTAssertFalse(html.contains("googletagmanager"))
            }
        }
    }

    func testUnconfiguredAppDoesNotReceiveMomokoPolicy() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try routes(app)
        try app.test(.GET, "apps/pixelblitz/privacy-policy") { response in
            XCTAssertEqual(response.status, .notFound)
        }
    }
}
