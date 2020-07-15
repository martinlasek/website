//
//  bw_User.swift
//  App
//
//  Created by Martin Lasek on 27.04.20.
//

import FluentPostgreSQL
import Vapor

final class bw_User: PostgreSQLModel, ExpressibleByUUID {
  var id: Int?
  var uuid: UUID
  
  var email: String?
  var password: String?
  
  init(id: Int? = nil, uuid: UUID, email: String? = nil, password: String? = nil) {
    self.id = id
    self.uuid = uuid
    self.email = email
    self.password = password
  }
  
  init(uuid: UUID) {
    self.uuid = uuid
  }
}

extension bw_User: Migration { }
extension bw_User: Content { }
extension bw_User: Parameter { }

extension bw_User {
  var wishList: Children<bw_User, bw_Wish> {
    return children(\.userId)
  }
}
