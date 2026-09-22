import XCTest

final class HTMLHeadDocumentTests: XCTestCase {
    func testHTMLVoidTagsPreserveHeadHierarchyAndEscapedMetadata() throws {
        let html = """
        <html><head><meta charset="utf-8"><meta name="description" content="Swift &amp; UI &gt; basics">
        <meta property="og:image:alt" content><link rel="stylesheet" href="https://example.com/style?a=1&b=2"><title>Swift &amp; UI &lt;Guide&gt;</title><link rel="canonical" href="https://example.com/">
        </head><body><svg><title>Unrelated icon title</title></svg></body></html>
        """
        let document = try HTMLHeadDocument.parse(html)
        XCTAssertEqual(try document.nodes(forXPath: "/head/title").map(\.stringValue), ["Swift & UI <Guide>"])
        XCTAssertEqual(try document.nodes(forXPath: "/head/meta[@name='description']/@content").map(\.stringValue), ["Swift & UI > basics"])
        XCTAssertEqual(try document.nodes(forXPath: "/head/link[@rel='canonical']/@href").map(\.stringValue), ["https://example.com/"])
        XCTAssertEqual(try document.nodes(forXPath: "/head/meta[@property='og:image:alt']/@content").map(\.stringValue), [""])
        XCTAssertEqual(try document.nodes(forXPath: "/head/link[@rel='stylesheet']/@href").map(\.stringValue), ["https://example.com/style?a=1&b=2"])
    }

    func testBodyTitleCannotMaskMissingPageTitle() throws {
        let document = try HTMLHeadDocument.parse("<html><head><meta charset=\"utf-8\"></head><body><title>Wrong place</title></body></html>")
        XCTAssertTrue(try document.nodes(forXPath: "//title").isEmpty)
    }
}
