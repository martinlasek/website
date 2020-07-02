//
//  socialdown_ListWishResponse.swift
//  App
//
//  Created by Martin Lasek on 06.05.20.
//

import Vapor

struct socialdown_ListWishResponse: Content {
  let list: [socialdown_SingleWishResponse]
}
