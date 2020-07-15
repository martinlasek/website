//
//  UUIDAuthMiddleware.swift
//  App
//
//  Created by Martin Lasek on 06.05.20.
//

import Vapor
import FluentPostgreSQL

extension Request {
  func user<U>() throws -> Future<U> where U: ExpressibleByUUID, U: PostgreSQLModel {
    var uuidOptional: UUID?
    
    // LEGACY CODE (06.05.20)
    // When function `user()` wasn't generic but socialdown specific.
    if let uuidString = http.headers.firstValue(name: HTTPHeaderName("x-socialdown-uuid")) {
      uuidOptional = UUID(uuidString: uuidString)
    }
    
    // Every new app will use `x-uuid`.
    if let uuidString = http.headers.firstValue(name: HTTPHeaderName("x-uuid")) {
      uuidOptional = UUID(uuidString: uuidString)
    }
    
    guard let uuid = uuidOptional else { throw Abort(.unauthorized) }
    
    return U.query(on: self).filter(\U.uuid, .equal, uuid).first().flatMap { user in
      if let user = user {
        return self.future(user)
      }
      
      let user = U(uuid: uuid)
      return user.save(on: self)
    }
  }
}
