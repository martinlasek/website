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
        let publishedAt = "8 Oct 2023"

        return Article(
            headline: headline,
            subheadline: subheadline,
            slug: slug,
            published_at: publishedAt,
            contentList: [
                .opener("Here’s how you can ignore the safeArea when using a UIHostingController."),

                .h2("The Problem"),

                .text("You are ignoring the safeArea in your outermost view. But when you present it using UIHostingController — it doesn’t work and your view is not expanding beyond the safe area."),

                .code("""
                    struct FeatureList: View {
                        var body: some View {

                            VStack {
                                ...
                            }
                            .background(Color.red)
                            .ignoresSafeArea(.all)
                        }
                    }
                """),

                .image(.a_001_the_problem),

                .h2("The Solution"),

                .text("Add a .frame(maxWidth: .infinity) modifier to your view. Take that view and wrap it inside a ZStack and add the background and ignoreSafeArea modifier to the ZStack."),

                .code("""
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
                """),

                .image(.a_001_the_solution),

                .text("That's it! You've successfully expanded your view beyond the safe area!")
            ]
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
