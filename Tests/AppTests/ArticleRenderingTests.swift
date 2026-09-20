@testable import App
import Dispatch
import HtmlVaporSupport
import XCTVapor

final class ArticleRenderingTests: XCTestCase {
    func testCodePreservesWhitespaceAndEscapesHTML() {
        let code = "\tlet value = \"<script>alert('hello')</script> &amp; > 🐱\"\n\n    print(value)\n"
        let html = Html.render(Node.codeblock(code))

        XCTAssertEqual(
            html,
            "<pre class=\"mb-3\"><code>\tlet value = \"&lt;script>alert('hello')&lt;/script> &amp;amp; > 🐱\"\n\n    print(value)\n</code></pre>"
        )
        XCTAssertFalse(html.contains("<script>"))
    }

    func testEmptyCodeBlock() {
        XCTAssertEqual(
            Html.render(Node.codeblock("")),
            "<pre class=\"mb-3\"><code></code></pre>"
        )
    }

    func testAllArticleRoutesRenderRepeatedly() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try routes(app)

        for _ in 0..<3 {
            for article in Article.all {
                try app.test(.GET, "articles/\(article.slug)") { response in
                    XCTAssertEqual(response.status, .ok, article.slug)
                    let html = response.body.string
                    XCTAssertTrue(html.contains(article.fullCanonUrl), article.slug)
                    XCTAssertTrue(html.contains(article.headline), article.slug)
                    XCTAssertTrue(html.contains(article.published_at.readableFormat), article.slug)

                    for content in article.contentList {
                        switch content {
                        case .code(let code):
                            XCTAssertTrue(
                                html.contains("<code>\(Html.escapeTextNode(text: code))</code>"),
                                "Missing or altered code in \(article.slug)"
                            )
                        case .image(let image):
                            XCTAssertTrue(html.contains(image.imgSrc), article.slug)
                        default:
                            break
                        }
                    }
                }
            }
        }
    }

    func testAllArticlesRenderConcurrently() {
        DispatchQueue.concurrentPerform(iterations: 100) { iteration in
            let article = Article.all[iteration % Article.all.count]
            let html = Html.render(Article.layout(for: article))

            XCTAssertTrue(html.contains(article.headline), article.slug)
            XCTAssertTrue(html.contains(article.published_at.readableFormat), article.slug)
            for content in article.contentList {
                if case .code(let code) = content {
                    XCTAssertTrue(
                        html.contains("<code>\(Html.escapeTextNode(text: code))</code>"),
                        article.slug
                    )
                }
            }
        }
    }
}
