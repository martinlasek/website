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
        let subheadline = "How to ignore the SafeArea when using a UIHostingController."
        let slug = "uihostingcontroller-and-safearea"
        let tweetLink = "https://twitter.com/intent/tweet?via=martinlasek&text=» \(headline.urlEncoded()) «&url=https://www.martinlasek.com/articles/\(slug)"

        return Article(
            headline: headline,
            subheadline: subheadline,
            slug: slug,
            published_at: "8 Oct 2023",
            
            node: {
                .div(attributes: [.class("article bg-body-tertiary")],
                     .h1(attributes: [.class("mb-3")], .text(headline)),

                    .p("Here’s how you can ignore the safeArea when using a UIHostingController."),

                    .h2("The Problem"),
                    .p("You are ignoring the safeArea in your outermost view. But when you present it using UIHostingController — it doesn’t work and your view is not expanding beyond the safe area."),

                    .codeblock(
                        """
                        struct FeatureList: View {
                            var body: some View {

                                VStack {
                                    ...
                                }
                                .background(Color.red)
                                .ignoresSafeArea(.all)
                            }
                        }
                        """
                    ),

                    .div(attributes: [.class("text-center p-5 pt-0")],
                         .img(src: Article.Image.a_001_the_problem.imgSrc, alt: "", attributes: [.class("w-100")])
                    ),

                    .h2("The Solution"),
                    .p("Add a .frame(maxWidth: .infinity) modifier to your view. Take that view and wrap it inside a ZStack and add the background and ignoreSafeArea modifier to the ZStack."),

                    .codeblock(
                        """
                        struct FeatureList: View {
                            var body: some View {
                                ZStack {
                                    VStack {
                                        ...
                                    }.frame(maxWidth: .infinity)
                                }
                                .background(Color.red)
                                .ignoresSafeArea(.all)
                            }
                        }
                        """
                    ),

                     .div(attributes: [.class("text-center p-5 pt-0")],
                          .img(src: Article.Image.a_001_the_solution.imgSrc, alt: "", attributes: [.class("w-100")])
                     ),

                    .p("That's it! You've successfully expanded your view beyond the safe area!"),

                    .p("I am happy you read my article and hope you found it useful! If you have any suggestions of any kind don't hesitate let me know. I’d love to hear from you! "),

                    .br,
                     
                    .div(attributes: [.class("pb-3")],
                         .a(attributes: [.href(tweetLink), .target(.blank), .class("share")],
                            .i(attributes: [.class("bi bi-twitter me-2")]),
                            .text("Share on Twitter")
                         )
                    )
                )
            }
        )
    }()
}

public extension String {
    func urlEncoded() -> String {
        addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
            .replacingOccurrences(of: "&", with: "%26")
            .replacingOccurrences(of: "+", with: "%2B")
        ?? ""
    }
}
