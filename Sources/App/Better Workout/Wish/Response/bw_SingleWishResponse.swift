//
//  bw_SingleWishResponse.swift
//  App
//
//  Created by Martin Lasek on 06.05.20.
//

import Vapor

struct bw_SingleWishResponse: Content {
  let id: Int
  let userUUID: UUID
  let title: String
  let description: String?
  let state: WishState
  let votingUsers: [bw_SingleUserResponse]
}
