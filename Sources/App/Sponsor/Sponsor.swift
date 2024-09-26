//
//  Sponsor.swift
//  website
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

struct Sponsor {
    let logoUrl: String
    let websiteLink: String
    let description: String
    let buttonText: String

    static var current: Sponsor {
        return example
    }

    static let all: [Sponsor] = [
        // WishKit
        example
    ]

    static var example: Sponsor {
        Sponsor(
            logoUrl: "/sponsors/wishkit-logo.png",
            websiteLink: "https://www.wishkit.io?ref=martinlasek",
            description: "Gather user feedback and manage feature requests directly within your app. Empower users to suggest features, vote on ideas, and collaborate, all while you prioritize based on popularity.",
            buttonText: "Try For Free"
        )
    }
}
