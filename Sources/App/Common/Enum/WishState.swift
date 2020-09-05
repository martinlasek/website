//
//  WishState.swift
//  App
//
//  Created by Martin Lasek on 05.09.20.
//

import FluentPostgreSQL

enum WishState: String, PostgreSQLEnum, PostgreSQLMigration, CaseIterable {
  case pending
  case approved
  case implemented
  case rejected
  
  static func reflectDecoded() throws -> (Self, Self) {
    return (.pending, .approved)
  }
}
