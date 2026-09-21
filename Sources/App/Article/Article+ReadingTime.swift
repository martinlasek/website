import Foundation

extension Article {
    /// A consistent estimate from authored content, excluding captions/markup and image filenames.
    var readingMinutes: Int {
        let text = contentList.map { content -> String in
            switch content {
            case .opener(let value), .h2(let value), .text(let value), .code(let value):
                return value
            case .list(let points):
                return points.map(\.value).joined(separator: " ")
            case .banner(.primary(let value)):
                return value
            case .link(let article):
                return article.headline
            case .image:
                return ""
            }
        }.joined(separator: " ")
        let count = text.split(whereSeparator: { $0.isWhitespace }).count
        return max(1, (count + 199) / 200)
    }
}
