//
//  bw_UserWish.swift
//  App
//
//  Created by Martin Lasek on 27.04.20.
//

import FluentPostgreSQL
import Vapor

final class bw_UserWish: PostgreSQLPivot {
  typealias Left = bw_Wish
  typealias Right = bw_User
  
  static var leftIDKey: LeftIDKey = \.wishId
  static var rightIDKey: RightIDKey = \.userId
  
  var id: Int?
  var userId: bw_User.ID
  var wishId: bw_Wish.ID
  
  init(id: Int? = nil, userId: bw_User.ID, wishId: bw_Wish.ID) {
    self.id = id
    self.userId = userId
    self.wishId = wishId
  }
}

extension bw_UserWish: Migration { }
