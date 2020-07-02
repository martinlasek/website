//
//  socialdown_User.swift
//  App
//
//  Created by Martin Lasek on 27.04.20.
//

import FluentPostgreSQL
import Vapor

final class socialdown_User: PostgreSQLModel {
  var id: Int?
  let uuid: UUID
  
  var email: String?
  var password: String?
  
  init(id: Int? = nil, uuid: UUID, email: String? = nil, password: String? = nil) {
    self.id = id
    self.uuid = uuid
    self.email = email
    self.password = password
  }
}

extension socialdown_User: Migration { }
extension socialdown_User: Content { }
extension socialdown_User: Parameter { }

extension socialdown_User {
  var wishList: Children<socialdown_User, socialdown_Wish> {
    return children(\.userId)
  }
}
