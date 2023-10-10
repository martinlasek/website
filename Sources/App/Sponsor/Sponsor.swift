//
//  File.swift
//  
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
            description: "Gather customer feedback and prioritize features that convert. WishKit allows you to build better products and best of all - it only takes 100 seconds to integrate.",
            buttonText: "Try For Free"
        )
    }
}
