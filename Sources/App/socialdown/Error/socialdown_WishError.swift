//
//  socialdown_WishError.swift
//  App
//
//  Created by Martin Lasek on 22.05.20.
//

import Vapor

struct socialdown_WishError: AbortError {
  var identifier: String
  var status: HTTPResponseStatus
  var headers: HTTPHeaders
  var reason: String
  
  private init(identifier: String, status: HTTPResponseStatus, headers: HTTPHeaders, reason: String) {
    self.identifier = identifier
    self.status = status
    self.headers = headers
    self.reason = reason
  }
  
  private init(enumKey: Kind) {
    self.init(identifier: enumKey.rawValue, status: .badRequest, headers: [:], reason: enumKey.rawValue)
  }
  
  private enum Kind: String {
    case userAlreadyVoted
    case titleAlreadyExists
    case cannotVoteForOwnWish
  }
  
  static var userAlreadyVoted: socialdown_WishError {
    return socialdown_WishError(enumKey: .userAlreadyVoted)
  }
  
  static var titleAlreadyExists: socialdown_WishError {
    return socialdown_WishError(enumKey: .titleAlreadyExists)
  }
  
  static var cannotVoteForOwnWish: socialdown_WishError {
    return socialdown_WishError(enumKey: .cannotVoteForOwnWish)
  }
}
