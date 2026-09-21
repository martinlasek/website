import Foundation

enum SiteURL {
    static let origin = "https://www.martinlasek.com"

    static func isValidPath(_ path: String) -> Bool {
        guard path.hasPrefix("/"), !path.hasPrefix("//") else { return false }
        if path == "/" { return true }
        return path.dropFirst().split(separator: "/", omittingEmptySubsequences: false).allSatisfy { segment in
            !segment.isEmpty && segment != "." && segment != ".."
                && segment.utf8.allSatisfy {
                    (97...122).contains($0) || (65...90).contains($0)
                        || (48...57).contains($0) || $0 == 45 || $0 == 95 || $0 == 46
                }
        }
    }

    static func absoluteURL(for path: String) -> String? {
        guard isValidPath(path) else { return nil }
        return origin + path
    }
}
