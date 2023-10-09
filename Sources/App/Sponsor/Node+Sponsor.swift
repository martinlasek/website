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
    static func sponsor(_ sponsor: Sponsor) -> Node {
        .div(attributes: [.class("mt-4 mb-4")],
             .a(attributes: [.href(sponsor.websiteLink), .class("sponsor d-block p-3"), .target(.blank)],
                .span(attributes: [.class("d-flex mb-3")],
                      .img(attributes: [.src(sponsor.logoUrl), .class("me-auto")]),
                      .span(attributes: [.class("align-self-start text-ml-red small")], .i("SPONSOR"))
                ),

                .p(attributes: [.class("mb-3")], .text(sponsor.description)),

                 .div(attributes: [.class("text-end")],
                      .button(attributes: [.class("btn btn-md ml-button")], .text(sponsor.buttonText))
                 )
             )
        )
    }
}
