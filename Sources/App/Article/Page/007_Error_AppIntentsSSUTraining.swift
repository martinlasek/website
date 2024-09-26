//
//  Article+006.swift
//  website
//
//  Created by Martin Lasek on 10/19/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport
import Splash

extension Article {

    static let a_007_Error_AppIntentsSSUTraining = Article(
        headline: "Error: Command AppIntentsSSUTraining failed with a nonzero exit code",
        subheadline: "How to fix the error 'Command AppIntentsSSUTraining failed with a nonzero exit code'",
        slug: "error-app-intents-ssu-training",
        published_at: .date(26, .sep, 2024),

        contentList: [
            .opener("Here’s how to fix the error 'Command AppIntentsSSUTraining failed with a nonzero exit code'"),

            .h2("The Problem"),
            .text("You are trying to run or build your project but you run into the following compilation error."),
            .image(.a_007_the_problem),

            .h2("The Solution"),
            .text("Select your project, then your target. From here go to the 'Build Settings' tab. Search for the world 'flexible' and you should be able to find 'Enable App Shortcuts Flexible Matching'. Set it to 'No'."),

            .image(.a_007_the_solution),

            .text("And that's it! You should now be able to build your project without any issues.")
        ]
    )
}
