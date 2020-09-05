//
//  socialdown_api_WishController.swift
//  App
//
//  Created by Martin Lasek on 05.05.20.
//

import Vapor

final class socialdown_api_WishController {
  func list(req: Request) throws -> Future<socialdown_ListWishResponse> {
    return socialdown_Wish.query(on: req)
      .filter(\.state, .notEqual, .rejected)
      .all()
      .flatMap { wishList in
      
      return try wishList.map { (wish: socialdown_Wish) -> Future<socialdown_SingleWishResponse> in
        
        return try wish.votingUsers.query(on: req).all().flatMap { (votingUsers: [socialdown_User]) in
          
          return wish.user.query(on: req).first().map { (user: socialdown_User?) in
            
            guard let user = user else { throw Abort(.badRequest) }
            
            return try socialdown_SingleWishResponse(
              id: wish.requireID(),
              userUUID: user.uuid,
              title: wish.title,
              description: wish.description,
              state: wish.state,
              votingUsers: votingUsers.map { socialdown_SingleUserResponse(uuid: $0.uuid) }
            )
          }
        }
      }.flatten(on: req).map { socialdown_ListWishResponse(list: $0) }
    }
  }
  
  func create(req: Request) throws -> Future<socialdown_CreateWishResponse> {
    return try req.user().flatMap { (user: socialdown_User) in
      return try req
        .content
        .decode(socialdown_CreateWishRequest.self)
        .map { createWishRequest in
        return (user, createWishRequest)
      }
    }.flatMap { (user, createWishRequest) in
      return socialdown_Wish
        .query(on: req)
        .filter(\.title, .equal, createWishRequest.title)
        .first()
        .map { existingWish in
          return (user, createWishRequest, existingWish)
      }
    }.flatMap { (user, createWishRequest, existingWish) -> Future<socialdown_Wish> in
    
      guard existingWish == nil else {
        throw socialdown_WishError.titleAlreadyExists
      }
      
      return try socialdown_Wish(
        userId: user.requireID(),
        title: createWishRequest.title,
        description: createWishRequest.description,
        state: createWishRequest.state
      ).save(on: req)
    }.map { savedWish in
      return socialdown_CreateWishResponse(
        title: savedWish.title,
        description: savedWish.description,
        state: savedWish.state
      )
    }
  }
  
  func vote(req: Request) throws -> Future<socialdown_SingleWishResponse> {
    return try req.user().flatMap { (user: socialdown_User) in
      return try req.parameters.next(socialdown_Wish.self).flatMap { wish in
        return try wish.votingUsers.query(on: req).all().flatMap { votingUsers in
          
          guard wish.userId != (try user.requireID()) else {
            throw socialdown_WishError.cannotVoteForOwnWish
          }
          
          guard !votingUsers.contains(where: { user.uuid == $0.uuid }) else {
            throw socialdown_WishError.userAlreadyVoted
          }
          
          return try socialdown_UserWish(userId: user.requireID(), wishId: wish.requireID()).save(on: req).flatMap { _ in
            
            return try wish.votingUsers.query(on: req).all().map { newVotingUsers in
              return try socialdown_SingleWishResponse(
                id: wish.requireID(),
                userUUID: user.uuid,
                title: wish.title,
                description: wish.description,
                state: wish.state,
                votingUsers: newVotingUsers.map { socialdown_SingleUserResponse(uuid: $0.uuid) }
              )
            }
          }
        }
      }
    }
  }
}
