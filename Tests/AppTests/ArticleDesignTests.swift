@testable import App
import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
#if canImport(JavaScriptCore)
import JavaScriptCore
#endif
import HtmlVaporSupport
import XCTVapor

final class ArticleDesignTests: XCTestCase {
    func testArticleDesignMetadataAndConditionalHighlighting() throws {
        let app = Vapor.Application(.testing)
        defer { app.shutdown() }
        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
        try routes(app)
        for article in Article.all {
            try app.test(.GET, article.canonicalPath) { response in
                let html = response.body.string
                XCTAssertEqual(response.status, .ok)
                XCTAssertTrue(html.contains("site-reading site-article"))
                XCTAssertTrue(html.contains("href=\"/blog\""))
                XCTAssertTrue(html.contains("aria-label=\"Martin on GitHub\""))
                XCTAssertFalse(html.contains("bootstrap"))
                XCTAssertEqual(html.contains("prism-swift.min.js"), article.hasSwiftCode)
                XCTAssertEqual(html.contains("data-manual"), article.hasSwiftCode)
                let start = try XCTUnwrap(html.range(of: "<script type=\"application/ld+json\">"))
                let tail = html[start.upperBound...]
                let end = try XCTUnwrap(tail.range(of: "</script>"))
                let data = Data(tail[..<end.lowerBound].utf8)
                let json = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
                XCTAssertEqual(json["url"] as? String, article.fullCanonUrl)
                XCTAssertEqual(json["headline"] as? String, article.headline)
                XCTAssertEqual(json["datePublished"] as? String, article.dateForSitemap)
                XCTAssertEqual(json["image"] as? String, article.fullImageUrl)
                XCTAssertNil(json["dateModified"])
                for content in article.contentList {
                    switch content {
                    case .opener(let text), .text(let text), .h2(let text):
                        XCTAssertTrue(html.contains(Html.escapeTextNode(text: text)))
                    default: break
                    }
                }
            }
        }
        for path in ["/", "/blog", "/apps", "/apps/momoko/privacy-policy"] {
            try app.test(.GET, path) { response in
                XCTAssertFalse(response.body.string.contains("prism-"))
            }
        }
        for file in ["prism-core.min.js", "prism-swift.min.js", "highlight-swift.js", "LICENSE"] {
            try app.test(.GET, "/scripts/prism-1.30.0/\(file)") { response in
                XCTAssertEqual(response.status, .ok)
                XCTAssertFalse(response.body.string.isEmpty)
            }
        }
    }

    func testStructuredDataCannotTerminateItsScriptElement() throws {
        let text = "\" & </script><script>alert(1)</script>\u{2028}"
        let article = Article(headline: text, subheadline: text, slug: "fixture", published_at: .date(1, .jan, 2026), contentList: [])
        let json = try article.structuredData()
        XCTAssertFalse(json.contains("<"))
        XCTAssertFalse(json.contains("&"))
        let decoded = try XCTUnwrap(JSONSerialization.jsonObject(with: Data(json.utf8)) as? [String: Any])
        XCTAssertEqual(decoded["headline"] as? String, text)
    }

    #if canImport(JavaScriptCore)
    func testVendoredSwiftGrammarPreservesCodeText() throws {
        let context = try XCTUnwrap(JSContext())
        var errors: [String] = []
        context.exceptionHandler = { _, exception in errors.append(exception?.toString() ?? "JavaScript error") }
        for file in ["prism-core.min.js", "prism-swift.min.js"] {
            let source = try String(contentsOfFile: "Public/scripts/prism-1.30.0/\(file)", encoding: .utf8)
            context.evaluateScript(source)
        }
        var samples = Article.all.flatMap { article in
            article.contentList.compactMap { content -> String? in
                if case .code(let code) = content { return code }
                return nil
            }
        }
        samples.append("\tlet text = \"<script> &amp; 🐱\"\n\n    print(text)\n")
        for sample in samples {
            context.setObject(sample, forKeyedSubscript: "codeSample" as NSString)
            let output = try XCTUnwrap(context.evaluateScript("Prism.highlight(codeSample, Prism.languages.swift, 'swift')")?.toString())
            XCTAssertTrue(output.contains("token"))
            // Compare Prism's span markup without an XML parser stripping blank text nodes.
            let plain = output.replacingOccurrences(of: "<span[^>]*>|</span>", with: "", options: .regularExpression)
                .replacingOccurrences(of: "&lt;", with: "<")
                .replacingOccurrences(of: "&amp;", with: "&")
            XCTAssertFalse(output.contains("<script"))
            XCTAssertEqual(plain, sample)
        }
        XCTAssertTrue(errors.isEmpty, errors.joined(separator: "\n"))
    }
    #endif
}
