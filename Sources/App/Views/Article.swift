//
//  Article.swift
//  
//
//  Created by Martin Lasek on 10/3/23.
//  Copyright © 2023 Martin Lasek. All rights reserved.
//

struct Article {
    let leafPath: String
    let tag: [Tag]

    enum Tag {
        case swiftui
        case uikit
        case spritekit
        case scenekit
    }
}
