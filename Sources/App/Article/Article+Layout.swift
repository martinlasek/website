//
//  Article+Layout.swift
//  webiste
//
//  Created by Martin Lasek on 10/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import Foundation
import HtmlVaporSupport

extension Article {

    static func excerpt(for article: Article) -> Node {
        return
            .a(attributes: [.href(article.canonicalPath), .class("article bg-body-tertiary mb-3 d-block")],
               .h1(.text(article.headline)),
               .p(attributes: [.class("text-secondary mb-1 small")], "Published on \(article.published_at.readableFormat)"),
               .p(attributes: [.class("mb-0")], .text(article.subheadline))
            )
    }

    static func layout(for article: Article) -> Node {
        var shareURL = URLComponents(string: "https://twitter.com/intent/tweet")!
        shareURL.queryItems = [
            URLQueryItem(name: "via", value: "martinlasek"),
            URLQueryItem(name: "text", value: "» \(article.headline) «"),
            URLQueryItem(name: "url", value: article.fullCanonUrl)
        ]
        // Query consumers commonly decode '+' as a space.
        shareURL.percentEncodedQuery = shareURL.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let tweetLink = shareURL.string!

        let modifiedDate: Node
        if let date = article.modifiedAt {
            modifiedDate = .span("Updated ", .time(attributes: [.init("datetime", date.iso8601)], .text(date.readableFormat)))
        } else {
            modifiedDate = .fragment([])
        }
        let body: Node = .fragment(article.contentList.map({ content in
                switch content {
                case .opener(let text):
                    return .fragment([
                        .p(.text(text)),
                        articleSponsor
                    ])

                case .h2(let text):
                    return .h2(.text(text))
                case .text(let text):
                    return .p(.text(text))
                case .code(let text):
                    return .codeblock(text)
                case .image(let image):
                    return .figure(attributes: [.class("site-tutorial-image")],
                                .init(.img(src: image.imgSrc, alt: "", attributes: [.init("loading", "lazy")]))
                    )
                case .list(let points):
                    return .ul(
                        .fragment(points.map({ point in
                            .li(.text(point.value))
                        }))
                    )
                case .banner(let kind):
                    switch kind {
                    case .primary(let text):
                        return .div(attributes: [.class("site-note")], .text(text))
                    }
                case .link(let article):
                    return .a(attributes: [.href(article.fullCanonUrl), .class("site-related-link"), .target(.blank)], .text(article.headline))
                }
            }))

        let artwork: Node = .fragment((article.hero ?? article.cover).map { cover in [
            .img(src: cover.path, alt: Html.escapeTextNode(text: cover.alt), attributes: [
                .init("width", String(cover.width)), .init("height", String(cover.height)), .init("fetchpriority", "high")
            ])
        ] } ?? [])
        return .fragment([
            DetailHero.content(
                title: article.headline, summary: article.subheadline,
                backLink: SiteLink(title: "← All posts", destination: "/blog"),
                artwork: artwork,
                details: .div(attributes: [.class("site-byline")],
                    .a(attributes: [.href("/about")], .text(article.author)),
                    .time(attributes: [.init("datetime", article.published_at.iso8601)], .text(article.published_at.readableFormat)),
                    .span(.text("\(article.readingMinutes) min read")),
                    modifiedDate
                )
            ),
            .div(attributes: [.class("site-wrap")],
                .article(attributes: [.class("site-reading site-article")],

            body,
                    
            .hr,

            .p(attributes: [.class("site-article-ending")], .text("I hope you found it useful! If you have any suggestions or feedback, let me know. I’d love to hear from you!")),

            .div(attributes: [.class("site-actions")],
                 .a(attributes: [.href(Html.escapeTextNode(text: tweetLink)), .target(.blank), .init("rel", "noopener"), .class("site-button")],
                    .text("Share on Twitter")
                 )
            )
        ))])
    }

    private static var articleSponsor: Node {
        let sponsor = Sponsor.current
        return .aside(attributes: [.class("site-sponsor"), .init("aria-label", "Sponsor")],
            .a(attributes: [.href(Html.escapeTextNode(text: sponsor.websiteLink)), .target(.blank), .init("rel", "sponsored noopener"),
                            .init("aria-label", "WishKit sponsor (opens in a new tab)"), .class("site-sponsor-link")],
                .div(attributes: [.class("site-sponsor-heading")],
                    .img(src: sponsor.logoUrl, alt: "WishKit", attributes: [.init("width", "100"), .init("loading", "lazy")]),
                    .span("Sponsor")),
                .p(.text(sponsor.description)),
                .span(attributes: [.class("site-button")], .text(sponsor.buttonText)))
        )
    }

}
