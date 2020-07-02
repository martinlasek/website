//
//  socialdown_SingleWishResponse.swift
//  App
//
//  Created by Martin Lasek on 06.05.20.
//

import Vapor

struct socialdown_SingleWishResponse: Content {
  let id: Int
  let userUUID: UUID
  let title: String
  let description: String?
  let state: socialdown_Wish.State
  let votingUsers: [socialdown_SingleUserResponse]
}
