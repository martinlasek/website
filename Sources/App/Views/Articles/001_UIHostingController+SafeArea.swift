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

    static var a_001_UIHostingControllerAndSafeArea: Article = {
        let headline = "UIHostingController + SafeArea"
        let subheadline = "How to ignore the SafeArea when using a UIHostingController"
        let slug = "uihostingcontroller-and-safearea"

        return Article(
            headline: headline,
            subheadline: subheadline,
            slug: slug,
            published_at: "8 Oct 2023",
            
            node: {
                .div(attributes: [.class("article bg-body-tertiary")],
                     .h1(.text(headline)),

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

                    .p("Here’s how you can ignore the safeArea when using a UIHostingController.")
                )
            }
        )
    }()
}
