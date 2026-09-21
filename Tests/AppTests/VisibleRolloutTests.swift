@testable import App
import Foundation
import XCTVapor

final class VisibleRolloutTests: XCTestCase {
    func testHomeAndBlogUseNewDesignAndPreserveLegacyDestinations() throws {
        let uncovered = Article(headline: "Test", subheadline: "Test", slug: "legacy-test", canonicalPath: "/articles/legacy-test", published_at: .date(1, .jan, 2026), contentList: [])
        XCTAssertThrowsError(try Article.validate([uncovered]))
        let app = Application(.testing)
        defer { app.shutdown() }
        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
        try routes(app)
        try app.test(.GET, "/") { response in
            let html = response.body.string
            XCTAssertTrue(html.contains("site-hero"))
            XCTAssertTrue(html.contains("Hi, I'm"))
            XCTAssertTrue(html.contains("href=\"/apps\""))
            XCTAssertTrue(html.contains("href=\"/blog\""))
            XCTAssertEqual(html.components(separatedBy: "class=\"site-post-card\"").count - 1, 3)
            XCTAssertFalse(html.contains("noindex"))
            XCTAssertFalse(html.contains("mailto:"))
        }
        try app.test(.GET, "/blog") { response in
            let html = response.body.string
            XCTAssertEqual(html.components(separatedBy: "class=\"site-post-card\"").count - 1, 7)
            for article in Article.all {
                XCTAssertTrue(html.contains("href=\"\(article.canonicalPath)\""))
                XCTAssertTrue(html.contains(article.cover!.path))
            }
        }
        for (old, destination) in [("/articles", "/blog"), ("/projects", "/apps")] {
            try app.test(.GET, old) { response in
                XCTAssertEqual(response.status, .movedPermanently)
                XCTAssertEqual(response.headers.first(name: .location), destination)
            }
        }
        for article in Article.all {
            try app.test(.GET, article.canonicalPath) { response in
                XCTAssertEqual(response.status, .ok)
                XCTAssertTrue(response.body.string.contains("src=\"\(article.cover!.path)\""))
                XCTAssertTrue(response.body.string.contains(article.published_at.readableFormat))
            }
            try app.test(.GET, article.cover!.path) { response in
                XCTAssertEqual(response.status, .ok)
                XCTAssertEqual(response.headers.contentType, .png)
            }
        }
        try app.test(.GET, SiteLayout.stylesheet) { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssertTrue(response.body.string.contains("site-hero"))
        }
    }
}
