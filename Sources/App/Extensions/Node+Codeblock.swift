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
        .pre(attributes: [.class("language-swift"), .init("tabindex", "0"), .init("aria-label", "Swift code example")],
             .code(attributes: [.class("language-swift")], .text(content)))
    }
}
