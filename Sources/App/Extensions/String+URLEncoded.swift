//
//  String+URLEncoded.swift
//
//
//  Created by Martin Lasek on 10/13/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

public extension String {
    func urlEncoded() -> String {
        addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)?
            .replacingOccurrences(of: "&", with: "%26")
            .replacingOccurrences(of: "+", with: "%2B")
        ?? ""
    }
}
