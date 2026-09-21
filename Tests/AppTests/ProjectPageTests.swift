@testable import App
import XCTVapor

final class ProjectPageTests: XCTestCase {
    func testDirectoryAliasAndCardsResolveWithoutRedirects() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try routes(app)

        var directory = ""
        try app.test(.GET, "/projects") { response in
            XCTAssertEqual(response.status, .ok)
            directory = response.body.string
            XCTAssertTrue(directory.contains("https://www.martinlasek.com/projects"))
        }
        try app.test(.GET, "/apps") { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssertNil(response.headers.first(name: .location))
            XCTAssertEqual(response.body.string, directory)
        }
        for project in ProjectCatalog.all {
            XCTAssertTrue(directory.contains("href=\"\(project.canonicalPath)\""))
            try app.test(.GET, project.canonicalPath) { response in
                let html = response.body.string
                XCTAssertEqual(response.status, .ok)
                XCTAssertTrue(html.contains("<h1>\(project.name)</h1>"))
                XCTAssertTrue(html.contains("https://www.martinlasek.com\(project.canonicalPath)"))
                XCTAssertTrue(html.contains(SiteLayout.stylesheet))
                XCTAssertFalse(html.contains("noindex"))
                for link in project.links {
                    XCTAssertTrue(html.contains("href=\"\(link.destination)\""))
                }
            }
            try app.test(.HEAD, project.canonicalPath) { response in
                XCTAssertEqual(response.status, .ok)
            }
        }
        for path in ["/projects/missing", "/apps/wishkit", "/projects/wishkit/missing"] {
            try app.test(.GET, path) { response in
                XCTAssertEqual(response.status, .notFound)
            }
        }
    }
}
