//
//  Article+Layout.swift
//  webiste
//
//  Created by Martin Lasek on 10/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

extension Article {

    static func excerpt(for article: Article) -> Node {
        return
            .div(attributes: [.class("article bg-body-tertiary mb-3")],
                 .a(attributes: [.href("/articles/\(article.slug)")],
                    .h1(.text(article.headline)),
                    .p(attributes: [.class("text-secondary mb-1 small")], "Published on \(article.published_at)"),
                    .p(attributes: [.class("mb-0")], .text(article.subheadline))
                 )
            )
    }

    static func layout(for article: Article) -> Node {
        let tweetLink = "https://twitter.com/intent/tweet?via=martinlasek&text=» \(article.headline.urlEncoded()) «&url=https://www.martinlasek.com/articles/\(article.slug)"

        return .div(attributes: [.class("article bg-body-tertiary")],
            .h1(attributes: [.class("mb-2")], .text(article.headline)),
            .p(attributes: [.class("text-secondary small")], "Published on \(article.published_at)"),


            .fragment(article.contentList.map({ content in
                switch content {
                case .opener(let text):
                    return .fragment([
                        .p(.text(text)),
                        .sponsor(.current)
                    ])

                case .h2(let text):
                    return .h2(.text(text))
                case .text(let text):
                    return .p(.text(text))
                case .code(let text):
                    return .codeblock(text)
                case .image(let image):
                    return .div(attributes: [.class("text-center p-5 pt-2")],
                                .img(src: image.imgSrc, alt: "", attributes: [.class("w-100")])
                    )
                case .list(let points):
                    return .ul(
                        .fragment(points.map({ point in
                            .li(.text(point.value))
                        }))
                    )
                }
            })),

            .p("I am happy you read my article and hope you found it useful! If you have any suggestions of any kind don't hesitate let me know. I’d love to hear from you!"),

            .br,

            .div(attributes: [.class("pb-3")],
                 .a(attributes: [.href(tweetLink), .target(.blank), .class("share")],
                    .i(attributes: [.class("bi bi-twitter me-2")]),
                    .text("Share on Twitter")
                 )
            )
        )
    }
}
