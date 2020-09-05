//
//  MetaInfo.swift
//  App
//
//  Created by Martin Lasek on 03.07.20.
//

import Vapor

struct MetaInfo: Encodable {
  let isUser: Bool
  let currentSite: CurrentSite
  let title: String
  let app: App
  
  enum CurrentSite: String, Codable {
    case login
    case register
    case index
    case wishList
  }
  
  enum App: String, Codable {
    case none
    case socialdown
    case betterworkout
  }

  /// General Information needed in every View
  /// Every view accesses it at the key "appInfo"
  ///
  /// - returns instance of AppInfo
  static func create(_ currentSite: CurrentSite, _ app: App, on req: Request) throws -> MetaInfo {
    return MetaInfo(
      isUser: try req.isAuthenticated(AdminUser.self),
      currentSite: currentSite,
      title: "Admin Panel",
      app: app
    )
  }
}
