//
//  PageBuilder+Base.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport
import Foundation

extension PageBuilder {
    static func base(navLink: NavLink, _ content: Node) -> Node {
        return base(navLink: navLink, { content })
    }
    
    static func base(navLink: NavLink, meta: MetaTagProvider, _ content: Node) -> Node {
        return base(navLink: navLink, meta: meta, { content })
    }

    static func base(navLink: NavLink, _ content: () -> Node) -> Node {
        let year = Calendar.current.component(.year, from: Date())
        
        return Node.html(attributes: [.lang(.en), .data("bs-theme", "dark")],
             head(canonUrlPath: navLink.href),
            .body(
                navigation(navLink: navLink),
                .div(attributes: [.class("\(navLink.id) container pt-4 pb-3")],
                     content()
                ),
                .footer(attributes: [.class("footer")],
                        .span(attributes: [.class("text-center small d-block pt-3 pb-5")],
                              .text("Copyright © \(year) Martin Lasek. All Rights Reserved.")
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

    static func base(navLink: NavLink, meta: MetaTagProvider, _ content: () -> Node) -> Node {
        let year = Calendar.current.component(.year, from: Date())
        
        return Node.html(attributes: [.lang(.en), .data("bs-theme", "dark")],
             head(meta),
            .body(
                navigation(navLink: navLink),
                .div(attributes: [.class("\(navLink.id) container pt-4 pb-3")],
                     content()
                ),
                .footer(attributes: [.class("footer")],
                        .span(attributes: [.class("text-center small d-block text-muted pt-3 pb-5")],
                              .text("Copyright © \(year) Martin Lasek. All Rights Reserved.")
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
