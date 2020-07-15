//
//  bw_WishError.swift
//  App
//
//  Created by Martin Lasek on 22.05.20.
//

import Vapor

struct bw_WishError: AbortError {
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
  
  static let userAlreadyVoted = bw_WishError(enumKey: .userAlreadyVoted)
  static let titleAlreadyExists = bw_WishError(enumKey: .titleAlreadyExists)
  static let cannotVoteForOwnWish = bw_WishError(enumKey: .cannotVoteForOwnWish)
}
