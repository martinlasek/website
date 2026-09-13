import HtmlVaporSupport

/// Shared, script-free layout. App-specific wording belongs in that app's page file.
struct AppInfoPage {
    let appName: String
    let appSlug: String
    let slug: String
    let title: String
    let sections: [(heading: String, text: String)]
    var referenceLinks: [(label: String, url: String)] = []

    var content: Node {
        .html(attributes: [.lang(.en)],
            .head(
                .meta(attributes: [.charset("utf-8")]),
                .meta(name: "viewport", content: "width=device-width, initial-scale=1"),
                .title("\(appName) — \(title)"),
                .meta(name: "description", content: "\(title) for \(appName), by Martin Lasek."),
                .link(attributes: [.rel(.init(rawValue: "canonical")), .href("https://www.martinlasek.com/apps/\(appSlug)/\(slug)")]),
                .style(safe: """
                :root { color-scheme: light dark; }
                body { margin: 0; background: #111827; color: #e5e7eb; font: 1.05rem/1.75 system-ui, sans-serif; }
                main { max-width: 760px; margin: auto; padding: 32px 24px 64px; }
                a { color: #93c5fd; text-underline-offset: 4px; }
                a:focus-visible { outline: 2px solid #facc15; outline-offset: 5px; }
                nav { display: flex; flex-wrap: wrap; gap: 12px 24px; margin: 24px 0 40px; }
                h1 { line-height: 1.2; font-size: clamp(2rem, 6vw, 3rem); }
                h2 { line-height: 1.4; margin-top: 32px; font-size: 1.3rem; }
                .muted { color: #aeb9cb; } footer { margin-top: 48px; border-top: 1px solid #475569; padding-top: 20px; }
                """)
            ),
            .body(
                .main(
                    .a(attributes: [.href("/")], "Martin Lasek"),
                    .nav(attributes: [.init("aria-label", "App information")],
                        .a(attributes: [.href("/apps/\(appSlug)/privacy-policy")], "Privacy policy"),
                        .a(attributes: [.href("/apps/\(appSlug)/terms")], "Terms"),
                        .a(attributes: [.href("/apps/\(appSlug)/support")], "Support")
                    ),
                    .p(attributes: [.class("muted")], .text(appName)),
                    .h1(.text(title)),
                    .p(attributes: [.class("muted")], "Last updated: September 12, 2026"),
                    .fragment(sections.map { section in
                        .section(.h2(.text(section.heading)), .p(.text(section.text)))
                    }),
                    .ul(.fragment(referenceLinks.map { link in
                        .li(.a(attributes: [.href(link.url)], .text(link.label)))
                    })),
                    .footer(
                        .p("Questions? ", .a(attributes: [.href("mailto:heylasek@gmail.com")], "heylasek@gmail.com")),
                        .p(attributes: [.class("muted")], "© Martin Lasek")
                    )
                )
            )
        )
    }
}
