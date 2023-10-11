//
//  Article.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

struct Article {
    let headline: String
    let subheadline: String
    let slug: String
    let published_at: String // "10 Oct 2023"
    let contentList: [Article.Content]

    static var latest: Article {
        let lastIndex = all.count - 1
        return all[lastIndex]
    }

    static var all: [Article] = [
        Article.a_002_FixingServerWithSpecifiedHostnameNotFound,
        Article.a_001_UIHostingControllerAndSafeArea
    ]

    var dateForSitemap: String {
        let components = published_at.split(separator: " ")

        guard components.count == 3 else { return "" }

        var month = ""
        switch components[1] {
        case "Jan": month = "01"
        case "Feb": month = "02"
        case "Mar": month = "03"
        case "Apr": month = "04"
        case "May": month = "05"
        case "Jun": month = "06"
        case "Jul": month = "07"
        case "Aug": month = "08"
        case "Sep": month = "09"
        case "Oct": month = "10"
        case "Nov": month = "11"
        case "Dec": month = "12"
        default: ()
        }

        let dayInt = Int(components[0]) ?? 0
        var day = components[0]
        
        if dayInt < 10 {
            day = "0\(dayInt)"
        }

        let year = components[2]

        return "\(year)-\(month)-\(day)"
    }
}

extension Article {
    enum Content {
        case opener(String)
        case h2(String)
        case text(String)
        case code(String)
        case image(Article.Image)
        case list([Bulletpoint])

        enum Bulletpoint {
            case point(String)

            var value: String {
                switch self {
                case .point(let value): return value
                }
            }
        }
    }
}
