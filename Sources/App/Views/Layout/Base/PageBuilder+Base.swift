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
    static func base(navLink: NavLink, shouldTrackAnalytics: Bool = false, _ content: Node) -> Node {
        return base(navLink: navLink, shouldTrackAnalytics: shouldTrackAnalytics, { content })
    }
    
    static func base(navLink: NavLink, meta: MetaTagProvider, shouldTrackAnalytics: Bool = false, _ content: Node) -> Node {
        return base(navLink: navLink, meta: meta, shouldTrackAnalytics: shouldTrackAnalytics, { content })
    }

    static func base(navLink: NavLink, shouldTrackAnalytics: Bool = false, _ content: () -> Node) -> Node {
        let year = Calendar.current.component(.year, from: Date())
        
        return Node.html(attributes: [.lang(.en), .data("bs-theme", "dark")],
             head(PageMetadata.page(for: navLink)),
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
                Analytics.scripts(isEnabled: shouldTrackAnalytics)
            )
        )
    }

    static func base(navLink: NavLink, meta: MetaTagProvider, shouldTrackAnalytics: Bool = false, _ content: () -> Node) -> Node {
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
                Analytics.scripts(isEnabled: shouldTrackAnalytics)
            )
        )
    }
}
