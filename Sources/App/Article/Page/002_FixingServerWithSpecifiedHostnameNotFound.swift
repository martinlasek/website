//
//  Article+002 Article.swift
//  website
//
//  Created by Martin Lasek on 10/10/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

extension Article {
    static var a_002_FixingServerWithSpecifiedHostnameNotFound: Article = {
        let headline = "How to fix: A server with the specified hostname could not be found"
        let subheadline = "When creating a new macOS app you won't be able to make a network request right away."
        let slug = "how-to-fix-server-with-unspecified-hostname-not-found"
        let tweetLink = "https://twitter.com/intent/tweet?via=martinlasek&text=» \(headline.urlEncoded()) «&url=https://www.martinlasek.com/articles/\(slug)"
        let publishedAt = "10 Oct 2023"

        return Article(
            headline: headline,
            subheadline: subheadline,
            slug: slug,
            published_at: publishedAt,
            contentList: [
                .opener("When you create a new macOS project and try to make a network request you will notice it won't work right away. Let's fix that!"),

                    .h2("The Problem"),

                    .text("When you try to make a network request you will see an error message in the console. Something like:"),

                    .list([
                        .point("A server with the specified hostname could not be found."),
                        .point("networkd_settings_read_from_file Sandbox is preventing this process from reading networkd settings file at “/Library/Preferences/com.apple.networkd.plist”, please add an exception.")
                    ]),

                    .h2("The Solution"),

                    .text("""
                        Select your blue project file in Xcode. Then on the right make sure you selected your project name under "Targets" and go to "Signing & Capabilities". Finally under App Sandbox check "Outgoing Connections".
                    """),

                    .image(.a_002_xcode_check_outgoing_connection),

                    .text("That’s it! Run the app again and try your network request, it should work now.")
            ]
        )
    }()
}

