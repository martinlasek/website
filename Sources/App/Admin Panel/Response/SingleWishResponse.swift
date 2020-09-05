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
  let state: WishState
  
  static func from<M: WishModel>(_ wishModel: M) throws -> SingleWishResponse {
    return SingleWishResponse(
      id: try wishModel.requireID(),
      title: wishModel.title,
      description: wishModel.description,
      state: wishModel.state
    )
  }
}
