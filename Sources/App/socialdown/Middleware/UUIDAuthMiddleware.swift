//
//  UUIDAuthMiddleware.swift
//  App
//
//  Created by Martin Lasek on 06.05.20.
//

import Vapor
import FluentPostgreSQL
/*
struct UUIDAuthMiddleware: Middleware {
  
  func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {
    guard let uuid = request.http.headers.firstValue(name: HTTPHeaderName("x-socialdown-uuid")) else {
      throw Abort(.unauthorized)
    }
    
    return socialdown_User.query(on: request).filter(\.uuid, .equal, uuid).first().flatMap { user in
      if let user = user {
        try request.content.encode(user)
        return try next.respond(to: request)
        
      }
      
      let user = socialdown_User(uuid: uuid)
      return user.save(on: request).flatMap { user in
        try request.content.encode(user)
        return try next.respond(to: request)
      }
    }
  }
}
 */

extension Request {
  func user() throws -> Future<socialdown_User> {
    guard
      let uuidString = http.headers.firstValue(name: HTTPHeaderName("x-socialdown-uuid")),
      let uuid = UUID(uuidString: uuidString)
    else {
      throw Abort(.unauthorized)
    }
    
    return socialdown_User.query(on: self).filter(\.uuid, .equal, uuid).first().flatMap { user in
      if let user = user {
        return self.future(user)
      }
      
      let user = socialdown_User(uuid: uuid)
      return user.save(on: self)
    }
  }
}
