struct Project {
    let slug: String
    let name: String
    let summary: String
    let category: String
    let overview: String
    let highlights: [String]
    let links: [SiteLink]

    var iconPath: String? = nil

    var canonicalPath: String { "/projects/" + slug }

    var card: AppCard {
        AppCard(name: name, summary: summary, platform: category, iconPath: iconPath,
                destination: SiteLink(title: name, destination: canonicalPath))
    }
}
