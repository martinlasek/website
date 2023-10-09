//
//  AboutPage.swift
//  website
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

struct AboutPage {
    static let content: Node = {
        PageBuilder.base(navLink: .about) {
            .div(attributes: [.class("c-card bg-body-tertiary")],
                 .h1("About"),

                .p("""
                    I have always been passionate about learning new and challenging technologies to then break it down into straight forward and digestible tutorials.
                    Following very much the idea of:
                """),

                .p(attributes: [.class("h5 fw-light p-3")],
                   .i("""
                        "If you can't explain it to a six-year-old, you don't understand it yourself." - Albert Einstein
                    """)
                ),

                .p("""
                    I hope you will find value in the content I create. Don't hesitate to reach out anytime if you have any questions or feedback. Your input is always appreciated!
                """)
            )
        }
    }()
}
