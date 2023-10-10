//
//  PageBuilder+Nav.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

enum NavLink: CaseIterable, Equatable {

    case articles
    case projects
    case sponsorship
    case about

    static var allCases: [NavLink] {
        return [
            .articles,
            .projects,
            .sponsorship,
            .about
        ]
    }

    var id: String {
        switch self {
        case .articles: "articles"
        case .projects: "projects"
        case .sponsorship: "sponsorship"
        case .about: "about"
        }
    }

    var description: String{
        switch self {
        case .articles: "Articles"
        case .projects: "Projects"
        case .sponsorship: "Sponsorship"
        case .about: "About"
        }
    }

    var href: String {
        switch self {
        case .articles: "articles"
        case .projects: "projects"
        case .sponsorship: "sponsorship"
        case .about: "about"
        }
    }
}

extension PageBuilder {
    static func navigation(navLink: NavLink, _ content: (() -> Node)? = nil) -> Node {
        .nav(attributes: [.class("p-4 navbar navbar-expand navigation")],
             .div(attributes: [.class("container-fluid")],
                  .div(attributes: [.class("w-100 d-flex justify-content-center flex-column text-center")],
                       
                        .p(attributes: [.class("h1 fw-bold text-light")], "Martin Lasek"),

                        .p(attributes: [.class("text-light")], "Swift Tutorials and iOS Tips and Tricks"),

                        .ul(attributes: [.class("navbar-nav m-auto")],
                            .li(attributes: [.class("nav-item")],
                                .div(attributes: [.class("btn-group"), .role(.init(rawValue: "role")), .ariaLabel("navigation")],
                                    .fragment(
                                        NavLink.allCases.map { link in
                                            .a(
                                                attributes: [.class("btn btn-sm btn-light \(link == navLink ? "active" : "")"), .href("/\(link.href)")],
                                               .text(link.description)
                                            )
                                        }
                                    )
                                )
                            )
                        )
                  )
             )
        )
    }
}
