//
//  PageBuilder+Base.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

extension PageBuilder {
    static func base(canonUrlPath: String = "", _ content: () -> Node) -> Node {
        return Node.html(attributes: [.lang(.en), .data("bs-theme", "dark")],
            head(canonUrlPath: canonUrlPath),
            .body(
                navigation(),
                .div(attributes: [.class("container pt-3 pb-3")],
                     content()
                )
            )
        )
    }
}
