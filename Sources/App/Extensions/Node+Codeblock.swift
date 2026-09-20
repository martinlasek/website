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
        // Splash's SwiftGrammar initialization traps on the deployed Linux runtime.
        // Keep code readable and HTML-escaped until highlighting is verified there.
        .pre(attributes: [.class("mb-3")], .code(.text(content)))
    }
}
