//
//  AdminUser.swift
//  App
//
//  Created by Martin Lasek on 03.07.20.
//

import FluentPostgreSQL
import Vapor
import Authentication

final class AdminUser: PostgreSQLModel {
  var id: Int?
  var username: String
  var password: String
  
  init(id: Int? = nil, username: String, password: String) {
    self.id = id
    self.username = username
    self.password = password
  }
}

extension AdminUser: Content {}
extension AdminUser: Migration {}

extension AdminUser: PasswordAuthenticatable {
  static var usernameKey: WritableKeyPath<AdminUser, String> {
    return \AdminUser.username
  }
  static var passwordKey: WritableKeyPath<AdminUser, String> {
    return \AdminUser.password
  }
}

extension AdminUser: SessionAuthenticatable {}
