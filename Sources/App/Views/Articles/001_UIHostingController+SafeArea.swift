//
//  001_UIHostingControllerAndSafeArea.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport
import Splash

extension Article {
    static var a_001_UIHostingControllerAndSafeArea: Node = {
        .div(attributes: [.class("article bg-body-tertiary")],
             .h1("UIHostingController + SafeArea"),

             .pre(
                .code(
                    .raw(
                       SyntaxHighlighter(format: HTMLOutputFormat()).highlight(
                          """
                          struct FeaturedLabel: View {
                              var text: String

                              var body: some View {
                                  HStack {
                                      Image(systemName: "star")
                                      Text(text)
                                  }
                                  .foregroundColor(.orange)
                                  .font(.headline)
                              }
                          }
                          """
                       )
                    )
                )
             ),

            .p(
                "Here’s how you can ignore the safeArea when using a UIHostingController."
            )
        )
    }()
}
