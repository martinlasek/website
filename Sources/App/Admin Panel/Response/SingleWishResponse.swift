//
//  SingleWishResponse.swift
//  App
//
//  Created by Martin Lasek on 04.07.20.
//

struct SingleWishResponse: Encodable {
  let id: Int
  let title: String
  let description: String
  let state: socialdown_Wish.State
  
  static func from(_ wishModel: socialdown_Wish) throws -> SingleWishResponse {
    return SingleWishResponse(
      id: try wishModel.requireID(),
      title: wishModel.title,
      description: wishModel.description,
      state: wishModel.state
    )
  }
}
