
//
//  socialdown_UserWish.swift
//  App
//
//  Created by Martin Lasek on 27.04.20.
//

import FluentPostgreSQL
import Vapor

final class socialdown_UserWish: PostgreSQLPivot {
  typealias Left = socialdown_Wish
  typealias Right = socialdown_User
  
  static var leftIDKey: LeftIDKey = \.wishId
  static var rightIDKey: RightIDKey = \.userId
  
  var id: Int?
  var userId: socialdown_User.ID
  var wishId: socialdown_Wish.ID
  
  init(id: Int? = nil, userId: socialdown_User.ID, wishId: socialdown_Wish.ID) {
    self.id = id
    self.userId = userId
    self.wishId = wishId
  }
}

extension socialdown_UserWish: Migration { }
