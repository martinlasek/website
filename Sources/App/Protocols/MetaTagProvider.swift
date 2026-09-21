protocol MetaTagProvider {
    /// Explicit root-relative path, e.g. /articles/existing-post or /blog/new-post.
    var canonicalPath: String { get }
    var headline: String { get }
    var subheadline: String { get }
    var imagePath: String? { get }
    var imageAlt: String? { get }
    var openGraphType: String { get }
}

extension MetaTagProvider {
    var imagePath: String? { nil }
    var imageAlt: String? { nil }
    var openGraphType: String { "website" }

    var fullCanonUrl: String {
        // Paths are authored in source, never copied from request headers or queries.
        precondition(SiteURL.isValidPath(canonicalPath), "Invalid canonical path")
        return SiteURL.origin + canonicalPath
    }

    var fullImageUrl: String? {
        imagePath.flatMap { SiteURL.absoluteURL(for: $0) }
    }
}
