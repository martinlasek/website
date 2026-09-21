struct PageMetadata: MetaTagProvider {
    let canonicalPath: String
    let headline: String
    let subheadline: String
    var imagePath: String? = nil
    var imageAlt: String? = nil

    static func page(for navigation: NavLink) -> PageMetadata {
        let description: String
        switch navigation {
        case .articles:
            description = "Swift tutorials and iOS development tips by Martin Lasek."
        case .projects:
            description = "Projects by Martin Lasek. More details coming soon."
        case .about:
            description = "About Martin Lasek, his projects, and writing on Swift and iOS development."
        case .sponsorship:
            description = "Information about sponsoring Martin Lasek's website and tutorials."
        }
        return PageMetadata(
            canonicalPath: "/" + navigation.href,
            headline: "\(navigation.description) | Martin Lasek",
            subheadline: description
        )
    }
}
