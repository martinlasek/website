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
            description: "Collect user feedback from your iOS and macOS app. Prioritize what features to build next based on user interest and votes.",
            buttonText: "Try For Free"
        )
    }
}
