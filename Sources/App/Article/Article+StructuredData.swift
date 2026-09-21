import Foundation

extension Article {
    var hasSwiftCode: Bool {
        contentList.contains { if case .code = $0 { return true }; return false }
    }

    func structuredData() throws -> String {
        var data: [String: Any] = [
            "@context": "https://schema.org", "@type": "BlogPosting",
            "headline": headline, "description": subheadline,
            "url": fullCanonUrl, "mainEntityOfPage": fullCanonUrl,
            "datePublished": published_at.iso8601,
            "author": ["@type": "Person", "name": author, "url": SiteURL.origin + "/about"]
        ]
        if let image = fullImageUrl { data["image"] = image }
        if let modifiedAt { data["dateModified"] = modifiedAt.iso8601 }
        let json = try JSONSerialization.data(withJSONObject: data, options: [.sortedKeys])
        return String(decoding: json, as: UTF8.self)
            .replacingOccurrences(of: "<", with: "\\u003c")
            .replacingOccurrences(of: ">", with: "\\u003e")
            .replacingOccurrences(of: "&", with: "\\u0026")
            .replacingOccurrences(of: "\u{2028}", with: "\\u2028")
            .replacingOccurrences(of: "\u{2029}", with: "\\u2029")
    }
}

extension Article.PublishedDate {
    var iso8601: String {
        switch self {
        case .date(let day, let month, let year):
            return "\(year)-\(month.numericValue)-\(day < 10 ? "0" : "")\(day)"
        }
    }
}
