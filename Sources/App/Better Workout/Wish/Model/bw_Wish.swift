//
//  bw_Wish.swift
//  App
//
//  Created by Martin Lasek on 27.04.20.
//

import FluentPostgreSQL
import Vapor

final class bw_Wish: PostgreSQLModel {
  var id: Int?
  let userId: bw_User.ID
  
  let title: String
  var description: String
  var state: State
  
  init(id: Int? = nil, userId: bw_User.ID, title: String, description: String, state: State) {
    self.id = id
    self.userId = userId
    self.title = title
    self.description = description
    self.state = state
  }
  
  enum State: String, PostgreSQLEnum, PostgreSQLMigration, CaseIterable {    
    case pending
    case approved
    case implemented
    case rejected
    
    static func reflectDecoded() throws -> (bw_Wish.State, bw_Wish.State) {
      return (.pending, .approved)
    }
  }
}

extension bw_Wish: Migration { }
extension bw_Wish: Content { }
extension bw_Wish: Parameter { }

extension bw_Wish {
  var votingUsers: Siblings<bw_Wish, bw_User, bw_UserWish> {
    return siblings()
  }
  
  var user: Parent<bw_Wish, bw_User> {
    return parent(\.userId)
  }
}
