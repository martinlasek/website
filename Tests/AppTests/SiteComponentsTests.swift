@testable import App
import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
import HtmlVaporSupport
import XCTVapor

final class SiteComponentsTests: XCTestCase {
    func testAnalyticsRunsOnceOnlyOnProductionMarketingPages() throws {
        for environment in [Environment.production, .testing, .development] {
            let app = Vapor.Application(environment)
            defer { app.shutdown() }
            try routes(app)
            let paths = ["/", "/articles", "/projects", "/about", "/sponsorship"] + Article.all.map(\.canonicalPath)
            for path in paths {
                try app.test(.GET, path) { response in
                    XCTAssertEqual(response.status, .ok)
                    let html = response.body.string
                    let expected = environment == .production ? 1 : 0
                    XCTAssertEqual(html.components(separatedBy: "https://www.googletagmanager.com/gtag/js?").count - 1, expected, path)
                    XCTAssertEqual(html.components(separatedBy: "gtag('config', 'G-EV6Z0YNYR1')").count - 1, expected, path)
                    XCTAssertFalse(html.contains(SiteLayout.stylesheet), "Legacy pages must not adopt new styles yet")
                }
            }
            for page in MomokoPages.all {
                try app.test(.GET, "/apps/\(page.appSlug)/\(page.slug)") { response in
                    XCTAssertFalse(response.body.string.contains("<script"))
                }
            }
            try app.test(.GET, "/component-preview") { response in
                XCTAssertEqual(response.status, .notFound)
            }
        }
    }

    func testSharedShellSupportsPrivatePreviewAndReadyNavigationOnly() throws {
        let meta = PageMetadata(canonicalPath: "/blog", headline: "Blog", subheadline: "Writing")
        let nav = [SiteLink(title: "Blog", destination: "/blog")]
        for isPreview in [false, true] {
            let html = Html.render(SiteLayout.page(
                metadata: meta, navigation: nav, footerLinks: nav, currentPath: "/blog",
                shouldTrackAnalytics: true, isPreview: isPreview, content: .h1("Blog")
            ))
            let doc = try document(html)
            XCTAssertEqual(try doc.nodes(forXPath: "//link[@rel='canonical']").count, 1)
            XCTAssertEqual(try doc.nodes(forXPath: "//main[@id='main']").count, 1)
            XCTAssertEqual(try doc.nodes(forXPath: "//details/summary").count, 1)
            XCTAssertEqual(try doc.nodes(forXPath: "//nav/a[@aria-current='page']").count, 2)
            XCTAssertEqual(try doc.nodes(forXPath: "//a[@href='/apps']").count, 0)
            XCTAssertEqual(html.contains("gtag('config'"), !isPreview)
            XCTAssertEqual(html.contains("noindex,nofollow"), isPreview)
            XCTAssertFalse(html.contains("bootstrap"))
            XCTAssertFalse(html.contains("fonts.googleapis"))
            XCTAssertFalse(html.contains("mailto:"))
        }
    }

    func testCardsAreSingleLinksWithRequiredCoversAndEscapedContent() throws {
        let value = "A \"quoted\" &amp; <script>title</script>"
        let article = Article(headline: value, subheadline: value, slug: "example", published_at: .date(1, .jan, 2026), category: "Swift", contentList: [])
        let cover = ArticleCover(path: "/articles/007_the_problem.png", alt: "", width: 1200, height: 630)
        let cards = SiteComponents.postGrid([PostCard(article: article, cover: cover), PostCard(article: article, cover: cover)])
        let cardHTML = Html.render(cards)
        XCTAssertFalse(cardHTML.contains("<script"))
        let doc = try document(cardHTML)
        XCTAssertEqual(try doc.nodes(forXPath: "//article/a").count, 2)
        XCTAssertTrue(try doc.nodes(forXPath: "//a//a").isEmpty)
        XCTAssertTrue(try doc.nodes(forXPath: "//script").isEmpty)
        XCTAssertTrue(try doc.nodes(forXPath: "//*[@id]").isEmpty, "Repeated cards must not create duplicate IDs")
        XCTAssertEqual(try doc.nodes(forXPath: "//article/a/@aria-label").first?.stringValue, value)
        XCTAssertEqual(try doc.nodes(forXPath: "//article/a/img[@width='1200'][@height='630'][@alt='']").count, 2)
        XCTAssertEqual(try doc.nodes(forXPath: "//div[@class='site-post-content']/*").prefix(3).map(\.name), ["div", "h3", "p"])
        let app = AppCard(name: value, summary: value, platform: "SDK", iconPath: "/sponsors/wishkit-logo.png",
                          destination: SiteLink(title: "WishKit", destination: "https://www.wishkit.io/?a=1&b=2"))
        let appHTML = Html.render(app.content)
        XCTAssertFalse(appHTML.contains("<script"))
        let appDoc = try document(appHTML)
        XCTAssertEqual(try appDoc.nodes(forXPath: "//article/a/@href").first?.stringValue, "https://www.wishkit.io/?a=1&b=2")
        XCTAssertTrue(try appDoc.nodes(forXPath: "//script").isEmpty)
    }

    func testReadingTimeUsesAuthoredContent() {
        let words = Array(repeating: "word", count: 201).joined(separator: " ")
        let article = Article(headline: "Not counted", subheadline: "Not counted", slug: "example", published_at: .date(1, .jan, 2026), contentList: [.text(words)])
        XCTAssertEqual(article.readingMinutes, 2)
        let short = Article(headline: "", subheadline: "", slug: "short", published_at: .date(1, .jan, 2026), contentList: [.image(.a_007_the_problem)])
        XCTAssertEqual(short.readingMinutes, 1)
    }

    // libxml's HTML4 tidy parser drops HTML5 elements such as article/nav/main.
    // Normalize HTML void elements for XML parsing so structural checks retain them.
    private func document(_ html: String) throws -> XMLDocument {
        let withoutScripts = html.replacingOccurrences(
            of: #"<script\b[^>]*>[\s\S]*?</script>"#, with: "", options: .regularExpression
        )
        let normalized = withoutScripts.replacingOccurrences(
            of: #"(<(?:meta|link|img)\b(?:[^"'>]|"[^"]*"|'[^']*')*)(?<!/)>"#,
            with: "$1/>", options: .regularExpression
        )
        return try XMLDocument(xmlString: normalized.replacingOccurrences(of: " alt ", with: " alt=\"\" "))
    }

    func testComponentGalleryAndOptionalLocalExport() throws {
        let navigation = [SiteLink(title: "Apps", destination: "/apps"), SiteLink(title: "Blog", destination: "/blog"), SiteLink(title: "About", destination: "/about")]
        let cards = Article.all.prefix(3).map { article in
            PostCard(article: article, cover: ArticleCover(path: "/preview-covers/\(article.slug).png", alt: "", width: 1200, height: 630))
        }
        let content: Node = .div(attributes: [.class("site-wrap")],
            SiteComponents.heading(eyebrow: "Local component gallery", title: "Built with the shared Swift components", summary: "Review at desktop, tablet, and mobile widths. Artwork remains provisional."),
            SiteComponents.postGrid(cards),
            .section(attributes: [.class("site-section")],
                .h2("Buttons"),
                .div(attributes: [.class("site-actions")], SiteComponents.button(navigation[0]), SiteComponents.button(navigation[1]))),
            .section(attributes: [.class("site-section")],
                .h2("App card · existing logo used for layout only"),
                SiteComponents.appGrid([AppCard(name: "WishKit", summary: "Collect feature requests and feedback inside your app.", platform: "SDK / service", iconPath: "/sponsors/wishkit-logo.png", destination: SiteLink(title: "WishKit", destination: "https://www.wishkit.io/"))])),
            .section(attributes: [.class("site-reading")],
                .h2("Reading styles"),
                .p("Readable text and ", .a(attributes: [.href("/articles")], "ordinary links"), "."),
                .pre(attributes: [.init("tabindex", "0"), .init("aria-label", "Swift code sample")],
                    .code(.text("let message = \"<Hello> & goodbye\"\n" + String(repeating: "longLine ", count: 25))))
            )
        )
        let html = Html.render(SiteLayout.page(metadata: PageMetadata(canonicalPath: "/blog", headline: "Component gallery", subheadline: "Local review only"), navigation: navigation, footerLinks: navigation + [SiteLink(title: "Sponsor", destination: "/sponsor")], currentPath: "/blog", isPreview: true, content: content))
        XCTAssertFalse(html.contains("<script"))
        XCTAssertTrue(html.contains("noindex,nofollow"))
        if let output = ProcessInfo.processInfo.environment["WEBSITE_COMPONENT_PREVIEW"] {
            var local = html.replacingOccurrences(of: "href=\"\(SiteLayout.stylesheet)\"", with: "href=\"../../../Public\(SiteLayout.stylesheet)\"")
                .replacingOccurrences(of: "src=\"/preview-covers/", with: "src=\"covers/")
                .replacingOccurrences(of: "src=\"/sponsors/", with: "src=\"../../../Public/sponsors/")
            for (path, file) in [("/", "home.html"), ("/apps", "apps.html"), ("/blog", "blog.html"), ("/about", "about.html"), ("/sponsor", "sponsor.html")] {
                local = local.replacingOccurrences(of: "href=\"\(path)\"", with: "href=\"\(file)\"")
            }
            local = local.replacingOccurrences(of: "href=\"/articles", with: "href=\"\(SiteURL.origin)/articles")
            try local.write(toFile: output, atomically: true, encoding: .utf8)
        }
    }
}
