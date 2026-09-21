@testable import App
import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
import HtmlVaporSupport
import XCTVapor

final class MetadataTests: XCTestCase {
    func testLegacyIdentityAndMetadataRemainConsistent() throws {
        let slugs = [
            "error-app-intents-ssu-training", "get-size-of-view-in-swiftui",
            "list-and-identifiable-in-swiftui", "understanding-state-in-swiftui",
            "how-to-add-a-placeholder-to-texteditor", "how-to-fix-server-with-unspecified-hostname-not-found",
            "uihostingcontroller-and-safearea"
        ]
        // Assert literal protected paths, not just agreement between generators.
        XCTAssertEqual(Set(Article.all.map(\.slug)), Set(slugs))
        let app = Vapor.Application(.testing)
        defer { app.shutdown() }
        try routes(app)
        for article in Article.all {
            XCTAssertEqual(article.canonicalPath, "/articles/\(article.slug)")
            XCTAssertNil(article.modifiedAt)
            try app.test(.GET, article.canonicalPath) { response in
                XCTAssertEqual(response.status, .ok)
                let head = try self.headDocument(response.body.string)
                XCTAssertEqual(try self.values(head, "//link[@rel='canonical']/@href"), [article.fullCanonUrl])
                XCTAssertEqual(try self.values(head, "//meta[@property='og:url']/@content"), [article.fullCanonUrl])
                XCTAssertEqual(try self.values(head, "//meta[@property='og:type']/@content"), ["article"])
                XCTAssertEqual(try self.values(head, "//meta[@name='description']/@content"), [article.subheadline])
                XCTAssertEqual(try self.values(head, "//title"), [article.headline])
                XCTAssertEqual(try self.values(head, "//meta[@property='og:image']/@content"), [article.fullImageUrl!])
                XCTAssertFalse(response.body.string.contains("default-share-image"))
                XCTAssertFalse(response.body.string.contains("/images/favicon/"))
            }
            try app.test(.GET, "/blog/\(article.slug)") { response in
                XCTAssertEqual(response.status, .notFound)
            }
        }
    }

    func testNewPostUsesBlogPathEverywhereWithoutPublishingFixture() throws {
        let article = fixture()
        let app = Vapor.Application(.testing)
        defer { app.shutdown() }
        try Article.register([article], on: app)
        XCTAssertEqual(article.canonicalPath, "/blog/test-post")
        XCTAssertTrue(Html.render(Article.excerpt(for: article)).contains("href=\"/blog/test-post\""))
        XCTAssertTrue(Sitemap.urls(for: [article]).contains(article.fullCanonUrl))
        try app.test(.GET, article.canonicalPath) { response in
            XCTAssertEqual(response.status, .ok)
            let head = try self.headDocument(response.body.string)
            XCTAssertEqual(try self.values(head, "//link[@rel='canonical']/@href"), [article.fullCanonUrl])
            XCTAssertEqual(try self.values(head, "//meta[@property='og:image']/@content"), [SiteURL.origin + "/articles/007_the_problem.png"])
            XCTAssertEqual(try self.values(head, "//meta[@name='twitter:card']/@content"), ["summary_large_image"])
        }
        let html = Html.render(Article.layout(for: article))
        let pattern = #"href="(https://twitter.com/intent/tweet[^"]*)""#
        let match = try XCTUnwrap(try NSRegularExpression(pattern: pattern).firstMatch(in: html, range: NSRange(html.startIndex..., in: html)))
        let range = try XCTUnwrap(Range(match.range(at: 1), in: html))
        let query = try XCTUnwrap(URLComponents(string: String(html[range]).replacingOccurrences(of: "&amp;", with: "&"))?.queryItems)
        XCTAssertTrue(String(html[range]).contains("%2B"))
        XCTAssertEqual(query.first { $0.name == "url" }?.value, article.fullCanonUrl)
        XCTAssertEqual(query.first { $0.name == "text" }?.value, "» \(article.headline) «")
        XCTAssertFalse(Article.all.contains { $0.slug == article.slug })
    }

    func testMetadataEscapesTextAndAttributesWithoutChangingValues() throws {
        let text = "Quotes \" &amp; <b> </title><script>alert(1)</script> 🐱"
        let meta = PageMetadata(canonicalPath: "/test", headline: text, subheadline: text,
                                imagePath: "/articles/007_the_problem.png", imageAlt: text)
        let html = Html.render(PageBuilder.head(meta))
        let document = try XMLDocument(xmlString: html, options: .documentTidyHTML)
        XCTAssertEqual(try values(document, "//title"), [text])
        for name in ["description", "twitter:title", "twitter:description", "twitter:image:alt"] {
            XCTAssertEqual(try values(document, "//meta[@name='\(name)']/@content"), [text])
        }
        XCTAssertTrue(try values(document, "//script").isEmpty)
    }

    func testPageMetadataAndPolicyPagesKeepTheirOwnIdentity() throws {
        let app = Vapor.Application(.testing)
        defer { app.shutdown() }
        try routes(app)
        for path in ["/", "/blog", "/about", "/apps", "/sponsor"] + MomokoPages.all.map({ "/apps/\($0.appSlug)/\($0.slug)" }) {
            try app.test(.GET, path) { response in
                let document = try self.headDocument(response.body.string)
                let canonicalPath = path
                XCTAssertEqual(try self.values(document, "//link[@rel='canonical']/@href"), [SiteURL.origin + canonicalPath])
                XCTAssertEqual(try self.values(document, "//meta[@property='og:type']/@content"), ["website"])
                XCTAssertEqual(try self.values(document, "//meta[@name='description']/@content").count, 1)
                if path.hasPrefix("/apps/") {
                    XCTAssertFalse(response.body.string.contains("<script"))
                    XCTAssertFalse(response.body.string.contains("fonts.googleapis"))
                    XCTAssertFalse(response.body.string.contains("gtag"))
                }
            }
        }
    }

    func testRejectsInvalidPathsDuplicateIdentitiesAndMissingCovers() throws {
        for path in ["blog/test-post", "//other.test/blog/test-post", "/blog/../test-post", "/blog/test-post/", "/blog/test-post?q=1", "/blog/test-post#section", "/blog/%74est-post", "/apps/test-post"] {
            XCTAssertThrowsError(try Article.validate([fixture(path: path)]), path)
        }
        XCTAssertThrowsError(try Article.validate([fixture(), fixture()]))
        XCTAssertThrowsError(try Article.validate([fixture(), fixture(path: "/articles/test-post")]))
        let noCover = Article(headline: "Test", subheadline: "Test", slug: "test-post", published_at: .date(1, .jan, 2026), contentList: [])
        XCTAssertThrowsError(try Article.validate([noCover]))
        for path in ["//other.test/image.png", "/images/../cover.png", "/cover.svg"] {
            XCTAssertThrowsError(try Article.validate([fixture(coverPath: path)]))
        }
        let app = Vapor.Application(.testing)
        defer { app.shutdown() }
        XCTAssertThrowsError(try Article.register([fixture(coverPath: "/missing-cover.png")], on: app))
        XCTAssertNil(SiteURL.absoluteURL(for: "//other.test/cover.png"))
        try Article.validate(Article.all)
    }

    private func fixture(path: String? = nil, coverPath: String = "/articles/007_the_problem.png") -> Article {
        Article(headline: "Swift & URLs + #fragments?", subheadline: "A private fixture.", slug: "test-post",
                canonicalPath: path, published_at: .date(1, .jan, 2026),
                cover: ArticleCover(path: coverPath, alt: "Build error", width: 1200, height: 630), contentList: [])
    }

    private func headDocument(_ html: String) throws -> XMLDocument {
        let start = try XCTUnwrap(html.range(of: "<head>"))
        let end = try XCTUnwrap(html.range(of: "</head>"))
        return try XMLDocument(xmlString: String(html[start.lowerBound..<end.upperBound]), options: .documentTidyHTML)
    }

    private func values(_ document: XMLDocument, _ xpath: String) throws -> [String] {
        try document.nodes(forXPath: xpath).compactMap(\.stringValue)
    }
}
