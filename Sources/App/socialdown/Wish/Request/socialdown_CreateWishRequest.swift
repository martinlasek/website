//
//  socialdown_CreateWishRequest.swift
//  App
//
//  Created by Martin Lasek on 22.05.20.
//

import Vapor

struct socialdown_CreateWishRequest: Codable {
  let title: String
  var description: String
  var state: WishState = .pending
}
