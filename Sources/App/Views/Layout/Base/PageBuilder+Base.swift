//
//  PageBuilder+Base.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

extension PageBuilder {
    static func base(canonUrlPath: NavLink, _ content: () -> Node) -> Node {
        return Node.html(attributes: [.lang(.en), .data("bs-theme", "dark")],
             head(canonUrlPath: canonUrlPath.href),
            .body(
                navigation(navLink: canonUrlPath),
                .div(attributes: [.class("container pt-4 pb-3")],
                     content()
                ),
                .footer(attributes: [.class("footer")],
                        .span(attributes: [.class("text-center small d-block text-muted pt-5 pb-3")],
                              .text("Copyright © 2023 Martin Lasek. All Rights Reserved.")
                        )
                )
            )
        )
    }
}
