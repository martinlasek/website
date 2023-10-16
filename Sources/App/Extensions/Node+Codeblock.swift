//
//  Node+Codeblock.swift
//  website
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport
import Splash

extension Node {
    static func codeblock(_ content: String) -> Node {
        .pre(attributes: [.class("mb-3")], .code(.raw(
            SyntaxHighlighter(format: HTMLOutputFormat()).highlight(content)
        )))
    }
}
