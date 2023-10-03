//
//  PageBuilder+Nav.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

extension PageBuilder {
    static func navigation(_ content: (() -> Node)? = nil) -> Node {
        .nav(attributes: [.class("p-4 navbar navbar-expand navigation")],
             .div(attributes: [.class("container-fluid")],
                  .div(attributes: [.class("w-100 d-flex justify-content-center flex-column text-center")],
                       
                        .p(attributes: [.class("h1 fw-bold text-light")], "Martin Lasek"),

                        .p(attributes: [.class("text-light")], "Swift Tutorials and iOS Tips and Tricks"),

                        .ul(attributes: [.class("navbar-nav m-auto")],
                            .li(attributes: [.class("nav-item")],
                                .div(attributes: [.class("btn-group"), .role(.init(rawValue: "role")), .ariaLabel("navigation")],

                                    .a(attributes: [.class("btn btn-sm btn-light"), .href("/tutorials")], "Tutorials"),
                                    .a(attributes: [.class("btn btn-sm btn-light"), .href("/projects")], "Projects"),
                                    .a(attributes: [.class("btn btn-sm btn-light"), .href("/about")], "About")
                                )
                            )
                        )
                  )
             )
        )
    }
}
