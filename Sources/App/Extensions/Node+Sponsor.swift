//
//  Node+Sponsor.swift
//  website
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport
import Splash

extension Node {
    static func sponsor(logoUrl: String, websiteLink: String, _ content: () -> Node) -> Node {
        .a(attributes: [.href(websiteLink), .class("sponsor d-block p-3"), .target(.blank)],
           .span(attributes: [.class("d-flex")],
                 .img(attributes: [.src(logoUrl), .class("pb-2 me-auto")]),
                 .span(attributes: [.class("align-self-start text-ml-red small")], .i("SPONSOR"))
           ),

           .p(content()),
           
           .div(attributes: [.class("text-end")],
                .button(attributes: [.class("btn btn-md ml-button")], .text("Try For Free!"))
           )
        )
    }
}
