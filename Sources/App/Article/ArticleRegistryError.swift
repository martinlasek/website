enum ArticleRegistryError: Error {

    case invalidPath(String)

    case duplicateIdentity(String)

    case invalidCover(String)

    case missingCover(String)
}
