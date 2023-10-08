//
//  Article.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

struct Article {
    let headline: String
    let subheadline: String
    let slug: String
    let published_at: String // 8 Oct 2023

    let node: () -> Node

    static var latest: Article {
        let lastIndex = all.count - 1
        return all[lastIndex]
    }

    static var all: [Article] = [
        Article.a_001_UIHostingControllerAndSafeArea
    ]

    static func excerpt(for article: Article) -> Node {
        return
            .div(attributes: [.class("article bg-body-tertiary")],
                 .h1(.text(article.headline)),
                 .p(attributes: [.class("text-muted mb-1 small")], "Published on \(article.published_at)"),
                 .p(.text(article.subheadline))
            )
    }
}
