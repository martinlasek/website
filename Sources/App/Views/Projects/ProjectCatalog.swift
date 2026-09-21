enum ProjectCatalog {
    static let all: [Project] = [
        Project(
            slug: "momoko", name: "Momoko", summary: "A game built around runs, waves, and character unlocks.",
            category: "Game",
            overview: "Momoko is one of my game projects. Its gameplay brings together waves, upgrades, and character unlocks across individual runs.",
            highlights: ["Play through waves and choose upgrades.", "Collect Moko and unlock characters."],
            links: [
                SiteLink(title: "Support", destination: "/apps/momoko/support"),
                SiteLink(title: "Privacy policy", destination: "/apps/momoko/privacy-policy"),
                SiteLink(title: "Terms", destination: "/apps/momoko/terms")
            ]
        ),
        Project(
            slug: "wishkit", name: "WishKit", summary: "Collect feature requests and feedback inside your app.",
            category: "SaaS",
            overview: "WishKit gives people a place to share ideas for your product. Collect feature requests and use votes to understand what your users want next.",
            highlights: ["Collect product feedback and feature requests.", "Let users vote on ideas."],
            links: [SiteLink(title: "Visit WishKit ↗", destination: "https://www.wishkit.io/")]
        ),
        Project(
            slug: "postburst", name: "PostBurst", summary: "Schedule and publish posts on X, Threads, and Bluesky.",
            category: "Web",
            overview: "PostBurst brings social publishing into one web dashboard, so you can prepare posts and schedule them across your connected accounts.",
            highlights: ["Schedule posts ahead of time.", "Publish on X, Threads, and Bluesky."],
            links: [SiteLink(title: "Visit PostBurst ↗", destination: "https://www.postburst.com/")]
        ),
        Project(
            slug: "readmarkdown", name: "ReadMarkdown", summary: "A focused Markdown reader with folder browsing and live file updates.",
            category: "macOS",
            overview: "ReadMarkdown is a read-only Markdown viewer for Mac. Open a document from Finder or browse a folder of Markdown files in its sidebar.",
            highlights: ["Read formatted text, tables, images, and selectable code blocks.", "See the preview update when a file changes on disk.", "Return to your last opened folder and file."],
            links: []
        )
    ]

    static var cards: [AppCard] {
        all.map(\.card) + [AppCard(name: "Bilingual Subtitles")]
    }
}
