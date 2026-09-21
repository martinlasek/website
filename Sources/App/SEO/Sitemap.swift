import Vapor

struct Sitemap {
    static let siteURL = SiteURL.origin

    static var urls: [String] { urls(for: Article.all) }

    static func urls(for articles: [Article]) -> [String] {
        ["/", "/blog", "/projects", "/about", "/sponsor"].map { siteURL + $0 }
        + ProjectCatalog.all.map { siteURL + $0.canonicalPath }
        + articles.map(\.fullCanonUrl)
        + MomokoPages.all.map { "\(siteURL)/apps/\($0.appSlug)/\($0.slug)" }
    }

    static func response() -> Response {
        Response(
            headers: ["Content-Type": "application/xml; charset=utf-8"],
            body: .init(string: render(urls: urls))
        )
    }

    static func render(urls: [String]) -> String {
        let entries = urls.map { "  <url><loc>\(escapeXML($0))</loc></url>" }.joined(separator: "\n")
        // Publication dates are not verified modification dates, so omit lastmod.
        return """
        <?xml version="1.0" encoding="UTF-8"?>
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
        \(entries)
        </urlset>
        """
    }

    private static func escapeXML(_ value: String) -> String {
        value
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&apos;")
    }
}
