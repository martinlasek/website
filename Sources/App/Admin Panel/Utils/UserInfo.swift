//
//  UserInfo.swift
//  App
//
//  Created by Martin Lasek on 03.07.20.
//

import Vapor

struct UserInfo: Encodable {
  let isUser: Bool
  let currentSite: CurrentSite
  let title: String
  
  enum CurrentSite: String, Codable {
    case login
    case register
    case index
    case wishList
  }

  /// General Information needed in every View
  /// Every view accesses it at the key "appInfo"
  ///
  /// - returns instance of AppInfo
  static func create(_ currentSite: CurrentSite, on req: Request) throws -> UserInfo {
    return UserInfo(
      isUser: try req.isAuthenticated(AdminUser.self),
      currentSite: currentSite,
      title: "Admin Panel"
    )
  }
}
