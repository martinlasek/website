//
//  socialdown_Wish.swift
//  App
//
//  Created by Martin Lasek on 27.04.20.
//

import FluentPostgreSQL
import Vapor

final class socialdown_Wish: WishModel {
  var id: Int?
  let userId: socialdown_User.ID
  
  let title: String
  var description: String
  var state: WishState
  
  init(id: Int? = nil, userId: socialdown_User.ID, title: String, description: String, state: WishState) {
    self.id = id
    self.userId = userId
    self.title = title
    self.description = description
    self.state = state
  }
  
  /// ⚠️ DEPRECATED! Use `WishState` instead.
  enum State: String, PostgreSQLEnum, PostgreSQLMigration, CaseIterable {    
    case pending
    case approved
    case implemented
    case rejected
    
    static func reflectDecoded() throws -> (socialdown_Wish.State, socialdown_Wish.State) {
      return (.pending, .approved)
    }
  }
}

extension socialdown_Wish: Migration { }
extension socialdown_Wish: Content { }
extension socialdown_Wish: Parameter { }

extension socialdown_Wish {
  var votingUsers: Siblings<socialdown_Wish, socialdown_User, socialdown_UserWish> {
    return siblings()
  }
  
  var user: Parent<socialdown_Wish, socialdown_User> {
    return parent(\.userId)
  }
}
