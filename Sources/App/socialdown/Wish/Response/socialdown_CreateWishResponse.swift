//
//  socialdown_CreateWishResponse.swift
//  App
//
//  Created by Martin Lasek on 22.05.20.
//

import Vapor

struct socialdown_CreateWishResponse: Content {
  let title: String
  var description: String?
  var state: socialdown_Wish.State
}
