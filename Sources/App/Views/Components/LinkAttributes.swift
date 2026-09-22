import Foundation
import HtmlVaporSupport

enum LinkAttributes {
    static func externalNavigation(for destination: String) -> [Attribute<Tag.A>] {
        guard let url = URLComponents(string: destination),
              let host = url.host?.lowercased(),
              url.scheme == "https" || url.scheme == "http" || url.scheme == nil,
              !["martinlasek.com", "www.martinlasek.com"].contains(host) else { return [] }
        return [.target(.blank), .init("rel", "noopener")]
    }
}
