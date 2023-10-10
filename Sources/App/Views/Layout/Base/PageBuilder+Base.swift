//
//  PageBuilder+Base.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

extension PageBuilder {
    static func base(navLink: NavLink, _ content: Node) -> Node {
        return base(navLink: navLink, { content })
    }
    
    static func base(navLink: NavLink, _ content: () -> Node) -> Node {
        return Node.html(attributes: [.lang(.en), .data("bs-theme", "dark")],
             head(canonUrlPath: navLink.href),
            .body(
                navigation(navLink: navLink),
                .div(attributes: [.class("\(navLink.id) container pt-4 pb-3")],
                     content()
                ),
                .footer(attributes: [.class("footer")],
                        .span(attributes: [.class("text-center small d-block text-muted pt-5 pb-3")],
                              .text("Copyright © 2023 Martin Lasek. All Rights Reserved.")
                        )
                ),
                .raw("""
                    <!-- Google tag (gtag.js) -->
                    <script async src="https://www.googletagmanager.com/gtag/js?id=G-EV6Z0YNYR1"></script>
                    <script>
                        window.dataLayer = window.dataLayer || [];
                        function gtag(){dataLayer.push(arguments);}
                        gtag('js', new Date());
                        gtag('config', 'G-EV6Z0YNYR1');
                    </script>
                """)
            )
        )
    }
}
