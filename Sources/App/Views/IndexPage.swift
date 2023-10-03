//
//  IndexPage.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

struct IndexPage {
    static func create(with latestArticle: Node) -> Node {
        PageBuilder.base {
            latestArticle
        }
    }
}
