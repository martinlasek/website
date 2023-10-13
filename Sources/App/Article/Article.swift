//
//  Article.swift
//  website
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

import HtmlVaporSupport

struct Article: MetaTagProvider {
    let headline: String
    let subheadline: String
    let slug: String
    let published_at: PublishedDate // "10 Oct 2023"

    // Used for the meta tag
    let imagePath: String?
    
    let contentList: [Article.Content]

    // Used for the meta tag
    var canonicalPath: String { return slug }

    init(
        headline: String,
        subheadline: String,
        slug: String,
        published_at: PublishedDate,
        imagePath: String? = nil,
        contentList: [Article.Content]
    ) {
        self.headline = headline
        self.subheadline = subheadline
        self.slug = slug
        self.published_at = published_at
        self.imagePath = imagePath
        self.contentList = contentList
    }

    static var latest: Article {
        let lastIndex = all.count - 1
        return all[lastIndex]
    }

    static var all: [Article] = [
        Article.a_003_texteditor_placeholder,
        Article.a_002_FixingServerWithSpecifiedHostnameNotFound,
        Article.a_001_UIHostingControllerAndSafeArea
    ]

    var dateForSitemap: String {
        switch published_at {
        case .date(let day, let month, let year):
            let dayResult = day < 10 ? "0\(day)" : String(day)
            return "\(year)-\(month.numericValue)-\(dayResult)"
        }
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

    enum PublishedDate {
        typealias Day = Int
        typealias Year = Int

        case date(Day, Article.Month, Year)

        var readableFormat: String {
            switch self {
            case .date(let day, let month, let year):
                return "\(day) \(month.rawValue) \(year)"
            }
        }
    }

    enum Month: String {
        case jan = "Jan"
        case feb = "Feb"
        case mar = "Mar"
        case apr = "Apr"
        case may = "May"
        case jun = "Jun"
        case jul = "Jul"
        case aug = "Aug"
        case sep = "Sep"
        case oct = "Oct"
        case nov = "Nov"
        case dec = "Dec"

        var numericValue: String {
            switch self {
            case .jan: return "01"
            case .feb: return "02"
            case .mar: return "03"
            case .apr: return "04"
            case .may: return "05"
            case .jun: return "06"
            case .jul: return "07"
            case .aug: return "08"
            case .sep: return "09"
            case .oct: return "10"
            case .nov: return "11"
            case .dec: return "12"
            }
        }
    }
}
