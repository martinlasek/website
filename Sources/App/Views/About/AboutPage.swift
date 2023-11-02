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
            .div(

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
                    """),

                    .br,

                    .div(attributes: [.class("text-center")],
                         .a(attributes: [.href("https://twitter.com/martinlasek"), .target(.blank), .class("ml-link")], .i(attributes: [.class("bi bi-twitter fs-4 me-3")])),
                         .a(attributes: [.href("https://github.com/martinlasek"), .target(.blank), .class("ml-link")], .i(attributes: [.class("bi bi-github fs-4")]))
                    )
                ),

                .div(attributes: [.class("c-card bg-body-tertiary mt-2 mb-5")],
                     .h2(attributes: [.class("mb-3")], "Featured In"),

                    .a(
                        attributes: [
                            .href("https://www.indiehackers.com/post/all-i-need-is-a-dry-place-a-laptop-and-the-internet-to-be-happy-ec647d9503"),
                            .class("fs-6 fw-bold mb-5 ml-link"),
                            .target(.blank)
                        ],
                        "IndieHackers.com"
                    ),
                     .p(.small("""
                            "All I need is a dry place, a laptop, and the internet to be happy."
                        """)
                     ),

                     .a(
                        attributes: [
                            .href("https://indiegoodies.com/interviews/martin_lasek"),
                            .class("fs-6 fw-bold mb-5 ml-link"),
                            .target(.blank)
                        ],
                        "IndieGoodies.com"
                     ),
                     .p(.small("""
                            "I always have a current side project. Not only to scratch that itch of manifesting ideas but also to keep growing my abilities to code."
                        """)
                     )
                )
            )
        }
    }()
}
