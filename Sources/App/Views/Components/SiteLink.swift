import Foundation

struct SiteLink {
    let title: String
    let destination: String

    /// Reject executable schemes and malformed paths before rendering authored links.
    init(title: String, destination: String) {
        precondition(
            SiteURL.isValidPath(destination)
                || (URLComponents(string: destination)?.scheme == "https"
                    && URLComponents(string: destination)?.host != nil),
            "Site links must use a local path or HTTPS"
        )
        self.title = title
        self.destination = destination
    }
}
