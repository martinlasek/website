import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
import XCTest

enum HTMLHeadDocument {
    static func parse(_ html: String) throws -> XMLDocument {
        let start = try XCTUnwrap(html.range(of: "<head>"))
        let end = try XCTUnwrap(html.range(of: "</head>", range: start.upperBound..<html.endIndex))
        let head = String(html[start.lowerBound..<end.upperBound])
        // Normalize authored HTML void tags, then use strict XML on both platforms.
        // HTML recovery changes the head/title hierarchy in Linux FoundationXML.
        let normalized = head.replacingOccurrences(
            of: #"(<(?:meta|link)\b(?:[^"'>]|"[^"]*"|'[^']*')*)(?<!/)>"#,
            with: "$1/>", options: .regularExpression
        )
        // swift-html emits an empty content value as a valueless HTML attribute.
        // Legacy stylesheet URLs also contain literal ampersands permitted in HTML.
        let xml = normalized
            .replacingOccurrences(of: " content/>", with: " content=\"\"/>")
            .replacingOccurrences(
                of: #"&(?!amp;|lt;|gt;|quot;|apos;|#[0-9]+;|#x[0-9a-fA-F]+;)"#,
                with: "&amp;", options: .regularExpression
            )
        return try XMLDocument(xmlString: xml)
    }
}
