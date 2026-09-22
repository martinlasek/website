import Foundation
import HtmlVaporSupport
import Vapor

extension Article {
    static func validate(_ articles: [Article]) throws {
        var paths = Set<String>()
        var slugs = Set<String>()
        for article in articles {
            guard SiteURL.isValidPath(article.canonicalPath), !article.slug.isEmpty,
                  article.slug.utf8.allSatisfy({ (97...122).contains($0) || (48...57).contains($0) || $0 == 45 }),
                  article.canonicalPath == "/articles/\(article.slug)"
                    || article.canonicalPath == "/blog/\(article.slug)" else {
                throw ArticleRegistryError.invalidPath(article.canonicalPath)
            }
            guard paths.insert(article.canonicalPath).inserted, slugs.insert(article.slug).inserted else {
                throw ArticleRegistryError.duplicateIdentity(article.slug)
            }
            if let cover = article.cover {
                guard SiteURL.isValidPath(cover.path), cover.width > 0, cover.height > 0,
                      ["png", "jpg", "jpeg"].contains((cover.path as NSString).pathExtension.lowercased()) else {
                    throw ArticleRegistryError.invalidCover(article.slug)
                }
            } else {
                throw ArticleRegistryError.missingCover(article.slug)
            }
        }
    }

    static func register(_ articles: [Article], on app: Vapor.Application) throws {
        try validate(articles)
        for article in articles {
            if let cover = article.cover {
                let file = app.directory.publicDirectory + String(cover.path.dropFirst())
                guard FileManager.default.fileExists(atPath: file) else {
                    throw ArticleRegistryError.invalidCover(article.slug)
                }
            }
            let path = article.canonicalPath.split(separator: "/").map { PathComponent.constant(String($0)) }
            app.on(.GET, path) { request -> Node in
                let json = try article.structuredData()
                return SiteLayout.page(
                    metadata: article, navigation: PublicSite.navigation,
                    footerLinks: PublicSite.navigation + [SiteLink(title: "Sponsor", destination: "/sponsor")],
                    currentPath: "/blog", shouldTrackAnalytics: request.application.environment == .production,
                    hasHeroBackdrop: true, hasSwiftCode: article.hasSwiftCode,
                    headContent: .init(.raw("<script type=\"application/ld+json\">\(json)</script>")),
                    content: Article.layout(for: article)
                )
            }
        }
    }
}
