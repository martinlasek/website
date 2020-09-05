//
//  SocialDownChangeStateType.swift
//  App
//
//  Created by Martin Lasek on 05.09.20.
//

import FluentPostgreSQL

struct SocialDownChangeStateTypeMigration: PostgreSQLMigration {
  typealias Database = PostgreSQLDatabase
  
  static func prepare(on conn: Database.Connection) -> EventLoopFuture<Void> {
    
    // casting `socialdown_wish_state` to `text` and then to `wishstate`
    // using `text` as a middleground.
    let query = """
    ALTER TABLE "socialdown_Wish"
    ALTER COLUMN state TYPE wishstate USING (state::text::wishstate)
    """
    
    return conn.raw(query).run()
  }
  
  static func revert(on conn: Database.Connection) -> EventLoopFuture<Void> {
    return PostgreSQLDatabase.delete(socialdown_Wish.self, on: conn)
  }
}

