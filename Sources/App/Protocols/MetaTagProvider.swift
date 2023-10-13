//
//  MetaTagProvider.swift
//  website
//
//  Created by Martin Lasek on 10/12/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

protocol MetaTagProvider {
    /// For example: articles/how-to-add-a-placeholder-to-texteditor
    var canonicalPath: String { get }

    // For example: How To: Add a placeholder to TextEditor in SwiftUI.
    var headline: String { get }

    // For example: SwiftUI currently only supports a placeholder for TextField but not for the TextEditor - Let's fix that!
    var subheadline: String { get }

    // For example: articles/002_xcode_check_outgoing_connection.png
    var imagePath: String? { get }
}

extension MetaTagProvider {
    var hostUrl: String {
        return "https://www.martinlasek.com"
    }

    var fullCanonUrl: String {
        return "\(hostUrl)/\(canonicalPath)"
    }

    var fullImageUrl: String {
        return "\(hostUrl)/\(imagePath ?? "default-share-image")"
    }
}
