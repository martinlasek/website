//
//  SponsorshipPage.swift
//  website
//
//  Created by Martin Lasek on 10/9/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

struct SponsorshipPage {
    static let content: Node = {
        PageBuilder.base(navLink: .sponsorship) {
            .div(attributes: [.class("c-card bg-body-tertiary")],
                 .h1("Sponsorship"),

                .p("""
                    I have been publishing content since August 2017 and have since been able to establish myself in the iOS and Swift community.
                    If you would you like to support my work feel free to reach out and share your product with developers all around the world.
                """),

                .div(attributes: [.class("text-center pb-3")],
                     .a(attributes: [.class("btn btn-md ml-button"), .mailto("heylasek@gmail.com")], .text("Become A Sponsor"))
                ),

                 // MARK: - Details

                .h2("Details"),

                .p("To keep pricing simple there's only one flat weekly rate that covers", .b(" exclusive "), "sponsorship for the site."),
                
                .p("""
                    You won't be placed alongside other sponsors or part of a rotating schedule. Instead, you'll enjoy exclusive sponsorship for an entire week.
                    What's more, your sponsorship package includes a special thank-you tweet from Martin Lasek, which will further enhance your visibility and reach.
                """),

                .p("You will get:"),

                .ul(
                    .li("Your ad placement on all content pages including your logo and a link."),
                    .li("A thank you ", .a(attributes: [.href("https://twitter.com/MartinLasek"), .class("ml-link")], "tweet from Martin"), " to his 3,400+ followers."),
                    .li("You are added to the list of sponsors with a backlink to your website."),
                    .li(.b("To top it off, the cost is just $100 per week for everything."))
                ),

                .br,

                .h2(attributes: [.class("pb-2")], "Example of an advertisement"),

                .sponsor(.example),

                .p("Thank you for considering supporting my work and allowing me to continue providing value to the Swift community!")
            )
        }
    }()
}
