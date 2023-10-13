//
//  Article+001.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport
import Splash

extension Article {
    
    static let a_001_UIHostingControllerAndSafeArea = Article(
        headline: "UIHostingController + SafeArea",
        subheadline: "How to ignore the SafeArea when using a UIHostingController.",
        slug: "uihostingcontroller-and-safearea",
        published_at: .date(8, .oct, 2023),

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
}
