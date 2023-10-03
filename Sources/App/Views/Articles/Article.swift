//
//  Article.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

struct Article {
    static var latest: Node {
        return all.first ?? Node()
    }

    static var all: [Node] = [
        Article.a_001_UIHostingControllerAndSafeArea
    ]
}
