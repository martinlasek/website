@testable import App
import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
import XCTVapor

final class SitemapTests: XCTestCase {
    func testSitemapEndpointsMatchAndContainWorkingCanonicalPages() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try routes(app)

        var sitemap = ""
        try app.test(.GET, "/sitemap.xml") { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssertEqual(response.headers.first(name: .contentType), "application/xml; charset=utf-8")
            sitemap = response.body.string
        }
        try app.test(.GET, "/sitemap") { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssertEqual(response.body.string, sitemap)
            XCTAssertEqual(response.headers.first(name: .contentType), "application/xml; charset=utf-8")
        }
        XCTAssertTrue(sitemap.hasPrefix("<?xml"))
        XCTAssertFalse(sitemap.contains("<lastmod>"))
        let document = try XMLDocument(xmlString: sitemap)
        let root = try XCTUnwrap(document.rootElement())
        XCTAssertEqual(root.name, "urlset")
        XCTAssertEqual(root.uri, "http://www.sitemaps.org/schemas/sitemap/0.9")
        let urls = root.elements(forName: "url").compactMap { $0.elements(forName: "loc").first?.stringValue }
        XCTAssertEqual(urls.count, 20)
        XCTAssertEqual(Set(urls).count, urls.count)
        XCTAssertTrue(urls.contains("https://www.martinlasek.com/articles/error-app-intents-ssu-training"))
        XCTAssertTrue(urls.contains("https://www.martinlasek.com/"))
        XCTAssertTrue(urls.contains("https://www.martinlasek.com/blog"))
        XCTAssertFalse(urls.contains("https://www.martinlasek.com/articles"))
        XCTAssertTrue(urls.contains("https://www.martinlasek.com/projects"))
        XCTAssertFalse(urls.contains("https://www.martinlasek.com/apps"))

        for url in urls {
            let path = try XCTUnwrap(URL(string: url)?.path)
            try app.test(.GET, path) { response in
                XCTAssertEqual(response.status, .ok, url)
                XCTAssertTrue(response.body.string.contains("href=\"\(url)\" rel=\"canonical\"")
                    || response.body.string.contains("rel=\"canonical\" href=\"\(url)\""), url)
            }
        }
        try app.test(.HEAD, "/sitemap.xml") { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssertEqual(response.headers.first(name: .contentType), "application/xml; charset=utf-8")
        }
    }

    func testSitemapEscapesURLsWithoutChangingTheirMeaning() throws {
        let url = "https://www.martinlasek.com/example?a=1&b=<value>&quote=\"'"
        let xml = Sitemap.render(urls: [url])
        XCTAssertTrue(xml.contains("&amp;"))
        XCTAssertTrue(xml.contains("&lt;"))
        let document = try XMLDocument(xmlString: xml)
        let value = document.rootElement()?.elements(forName: "url").first?.elements(forName: "loc").first?.stringValue
        XCTAssertEqual(value, url)
    }

    func testRobotsAllowsPublicContentAndPointsToPreferredSitemap() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try routes(app)
        try app.test(.GET, "/robots.txt") { response in
            XCTAssertEqual(response.status, .ok)
            XCTAssertEqual(response.headers.first(name: .contentType), "text/plain; charset=utf-8")
            XCTAssertEqual(response.body.string, "User-agent: *\nAllow: /\nSitemap: https://www.martinlasek.com/sitemap.xml\n")
        }
    }
}
