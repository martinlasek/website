//
//  PageBuilder+Head.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

extension PageBuilder {
    static func head(_ meta: MetaTagProvider) -> ChildOf<Tag.Html> {
        return .head(
            .meta(attributes: [.charset("utf-8")]),
            .meta(name: "viewport", content: "width=device-width, initial-scale=1"),

            .title(meta.headline),

            .init(.raw("<!-- Canonical -->")),
            .link(attributes: [
                .href(meta.fullCanonUrl),
                .rel(.init(rawValue: "canonical"))
            ]),

            // MARK: - Meta Tag: Twitter
            .init(.raw("<!-- Twitter -->")),
            .meta(name: "twitter:card", content: "summary_large_image"),
            .meta(name: "twitter:title", content: meta.headline),
            .meta(name: "twitter:description", content: meta.subheadline),
            .meta(name: "twitter:image", content: meta.fullImageUrl),
            .meta(name: "twitter:site", content: "@martinlasek"),
            .meta(name: "twitter:creator", content: "@martinlasek"),

            // MARK: - Meta Tag: Twitter
            .init(.raw("<!-- Facebook -->")),
            .meta(property: "og:type", content: "article"),
            .meta(property: "og:title", content: meta.headline),
            .meta(property: "og:description", content: meta.subheadline),
            .meta(property: "og:url", content: meta.fullCanonUrl),
            .meta(property: "og:image", content: meta.fullImageUrl),

            // MARK: - Favicon

            .init(.raw("<!-- FavIcon -->")),
            .link(attributes: [
                .rel(.init(rawValue: "apple-touch-icon")),
                .init("sizes", "180x180"),
                .href("/images/favicon/apple-touch-icon.png")
            ]),

            .link(attributes: [
                .rel(.icon),
                .type(.image(.png)),
                .init("sizes", "32x32"),
                .href("/images/favicon/favicon-32x32.png")
            ]),

            .link(attributes: [
                .rel(.icon),
                .type(.image(.png)),
                .init("sizes", "16x16"),
                .href("/images/favicon/favicon-16x16.png")
            ]),

            .link(attributes: [
                .rel(.init(rawValue: "manifest")),
                .href("/images/favicon/site.webmanifest")
            ]),

            // MARK: - CDN

            .init(.raw("<!-- CDN -->")),
            .link(attributes: [
                .href("https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"),
                .rel(.stylesheet),
                .init("integrity", "sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"),
                .init("crossorigin", "anonymous")
            ]),

            .link(attributes: [
                .href("https://fonts.googleapis.com/css2?family=Roboto:wght@300;500;900&display=swap"),
                .rel(.stylesheet)
            ]),

            .link(attributes: [
                .href("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"),
                .rel(.stylesheet)
            ]),

            // MARK:  - CUSTOM

            .init(.raw("<!-- CSS -->")),
            .link(attributes: [
                .href("/styles/main-09-24-2024.css"),
                .rel(.stylesheet)
            ]),

            .link(attributes: [
                .href("/styles/swift-syntax.css"),
                .rel(.stylesheet)
            ])
        )
    }

    static func head(
        canonUrlPath: String,
        _ content: (() -> Node)? = nil
    ) -> ChildOf<Tag.Html> {
        .head(
            .meta(attributes: [.charset("utf-8")]),
            .meta(name: "viewport", content: "width=device-width, initial-scale=1"),
            
            .title("Martin Lasek"),

            .link(attributes: [
                .href("https://www.martinlasek.com/\(canonUrlPath)"),
                .rel(.init(rawValue: "canonical"))
            ]),

            // MARK: - Favicon

            .link(attributes: [
                .rel(.init(rawValue: "apple-touch-icon")),
                .init("sizes", "180x180"),
                .href("/images/favicon/apple-touch-icon.png")
            ]),

            .link(attributes: [
                .rel(.icon),
                .type(.image(.png)),
                .init("sizes", "32x32"),
                .href("/images/favicon/favicon-32x32.png")
            ]),

            .link(attributes: [
                .rel(.icon),
                .type(.image(.png)),
                .init("sizes", "16x16"),
                .href("/images/favicon/favicon-16x16.png")
            ]),

            .link(attributes: [
                .rel(.init(rawValue: "manifest")),
                .href("/images/favicon/site.webmanifest")
            ]),

            // MARK: - CDN

            .link(attributes: [
                .href("https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"),
                .rel(.stylesheet),
                .init("integrity", "sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"),
                .init("crossorigin", "anonymous")
            ]),

            .link(attributes: [
                .href("https://fonts.googleapis.com/css2?family=Roboto:wght@300;500;900&display=swap"),
                .rel(.stylesheet)
            ]),

            .link(attributes: [
                .href("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"),
                .rel(.stylesheet)
            ]),

            // MARK:  - CUSTOM

            .link(attributes: [
                .href("/styles/main-09-24-2024.css"),
                .rel(.stylesheet)
            ]),

            .link(attributes: [
                .href("/styles/swift-syntax.css"),
                .rel(.stylesheet)
            ])
        )
    }
}
