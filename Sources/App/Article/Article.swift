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
    let published_at: String
    let contentList: [Article.Content]

    static var latest: Article {
        let lastIndex = all.count - 1
        return all[lastIndex]
    }

    static var all: [Article] = [
        Article.a_002_FixingServerWithSpecifiedHostnameNotFound,
        Article.a_001_UIHostingControllerAndSafeArea
    ]
}

extension Article {
    enum Content {
        case opener(String)
        case h2(String)
        case text(String)
        case code(String)
        case image(Article.Image)
        case list([Bulletpoint])

        enum Bulletpoint {
            case point(String)

            var value: String {
                switch self {
                case .point(let value): return value
                }
            }
        }
    }
}
