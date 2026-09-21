@testable import App
import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
import XCTVapor

final class SEOAuditTests: XCTestCase {
    func testCanonicalPagesHaveConsistentMetadataAndWorkingInternalLinks() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
        try routes(app)

        let canonicalPaths = Set(Sitemap.urls.compactMap { URL(string: $0)?.path })
        var documents: [String: XMLDocument] = [:]
        var markup: [String: String] = [:]
        var titles = Set<String>()
        var descriptions = Set<String>()
        for path in canonicalPaths.sorted() {
            try app.test(.GET, path) { response in
                XCTAssertEqual(response.status, .ok, path)
                XCTAssertNil(response.headers.first(name: .location), path)
                XCTAssertFalse(response.body.string.contains("noindex"), path)
                let document = try XMLDocument(xmlString: response.body.string, options: .documentTidyHTML)
                documents[path] = document
                markup[path] = response.body.string
                let title = try self.values(document, "//head/title")
                let description = try self.values(document, "//meta[@name='description']/@content")
                XCTAssertEqual(title.count, 1, path)
                XCTAssertEqual(description.count, 1, path)
                XCTAssertFalse(title.first?.isEmpty ?? true, path)
                XCTAssertFalse(description.first?.isEmpty ?? true, path)
                XCTAssertTrue(titles.insert(title.first ?? "").inserted, "Duplicate title: \(path)")
                XCTAssertTrue(descriptions.insert(description.first ?? "").inserted, "Duplicate description: \(path)")
                XCTAssertEqual(try self.values(document, "//h1").count, 1, path)
                XCTAssertEqual(try self.values(document, "//link[@rel='canonical']/@href"), [SiteURL.origin + path], path)
                XCTAssertEqual(try self.values(document, "//meta[@property='og:url']/@content"), [SiteURL.origin + path], path)
                XCTAssertEqual(try self.values(document, "//meta[@property='og:title']/@content"), title, path)
                XCTAssertEqual(try self.values(document, "//meta[@name='twitter:description']/@content"), description, path)
            }
            try app.test(.GET, path + "?utm_source=audit") { response in
                let document = try XMLDocument(xmlString: response.body.string, options: .documentTidyHTML)
                XCTAssertEqual(try self.values(document, "//link[@rel='canonical']/@href"), [SiteURL.origin + path])
            }
        }

        var graph: [String: Set<String>] = [:]
        var assets = Set<String>()
        for (path, document) in documents {
            for href in try values(document, "//a/@href") {
                let url = try XCTUnwrap(URL(string: href, relativeTo: URL(string: SiteURL.origin + path))?.absoluteURL)
                guard url.host == URL(string: SiteURL.origin)?.host else { continue }
                let destination = url.path
                XCTAssertTrue(canonicalPaths.contains(destination), "\(path) links to noncanonical or missing page: \(href)")
                graph[path, default: []].insert(destination)
                if let fragment = url.fragment?.removingPercentEncoding, !fragment.isEmpty {
                    XCTAssertTrue(markup[destination]?.contains("id=\"\(fragment)\"") == true,
                                  "Missing fragment: \(path) → \(href)")
                }
            }
            let references = try values(document, "//img/@src | //source/@srcset | //script/@src | //link[@rel='stylesheet' or @rel='icon' or @rel='apple-touch-icon']/@href | //meta[@property='og:image']/@content | //meta[@name='twitter:image']/@content")
            for reference in references {
                let url = try XCTUnwrap(URL(string: reference, relativeTo: URL(string: SiteURL.origin + path))?.absoluteURL)
                if url.host == URL(string: SiteURL.origin)?.host { assets.insert(url.path) }
            }
        }
        for path in assets.sorted() {
            try app.test(.GET, path) { response in
                XCTAssertEqual(response.status, .ok, "Missing asset: \(path)")
                XCTAssertGreaterThan(response.body.readableBytes, 0, path)
            }
        }
        var reachable: Set<String> = ["/"]
        var pending = ["/"]
        while let path = pending.popLast() {
            for destination in graph[path, default: []] where reachable.insert(destination).inserted {
                pending.append(destination)
            }
        }
        XCTAssertEqual(reachable, canonicalPaths, "Every sitemap page should be reachable from the homepage")
    }

    func testMissingPagesAndUnpublishedArticleAliasesReturn404() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try routes(app)
        let paths = ["/missing-page", "/articles/missing", "/blog/missing", "/projects/missing"]
            + Article.all.map { "/blog/" + $0.slug }
        for path in paths {
            try app.test(.GET, path) { response in
                XCTAssertEqual(response.status, .notFound, path)
                XCTAssertNil(response.headers.first(name: .location), path)
            }
        }
    }

    private func values(_ document: XMLDocument, _ xpath: String) throws -> [String] {
        try document.nodes(forXPath: xpath).compactMap(\.stringValue)
    }
}
