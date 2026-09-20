//
//  Node+Codeblock.swift
//  website
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

extension Node {
    static func codeblock(_ content: String) -> Node {
        // Keep code HTML-escaped and readable without client-side highlighting.
        .pre(attributes: [.class("mb-3")], .code(.text(content)))
    }
}
