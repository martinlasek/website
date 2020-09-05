//
//  bw_api_WishController.swift
//  App
//
//  Created by Martin Lasek on 05.05.20.
//

import Vapor

final class bw_api_WishController {
  func list(req: Request) throws -> Future<bw_ListWishResponse> {
    return bw_Wish.query(on: req)
      .filter(\.state, .notEqual, .rejected)
      .all()
      .flatMap { wishList in
      
      return try wishList.map { (wish: bw_Wish) -> Future<bw_SingleWishResponse> in
        
        return try wish.votingUsers.query(on: req).all().flatMap { (votingUsers: [bw_User]) in
          
          return wish.user.query(on: req).first().map { (user: bw_User?) in
            
            guard let user = user else { throw Abort(.badRequest) }
            
            return try bw_SingleWishResponse(
              id: wish.requireID(),
              userUUID: user.uuid,
              title: wish.title,
              description: wish.description,
              state: wish.state,
              votingUsers: votingUsers.map { bw_SingleUserResponse(uuid: $0.uuid) }
            )
          }
        }
      }.flatten(on: req).map { bw_ListWishResponse(list: $0) }
    }
  }
  
  func create(req: Request) throws -> Future<bw_CreateWishResponse> {
    return try req.user().flatMap { (user: bw_User) in
      return try req
        .content
        .decode(bw_CreateWishRequest.self)
        .map { createWishRequest in
        return (user, createWishRequest)
      }
    }.flatMap { (user, createWishRequest) in
      return bw_Wish
        .query(on: req)
        .filter(\.title, .equal, createWishRequest.title)
        .first()
        .map { existingWish in
          return (user, createWishRequest, existingWish)
      }
    }.flatMap { (user, createWishRequest, existingWish) -> Future<bw_Wish> in
    
      guard existingWish == nil else {
        throw bw_WishError.titleAlreadyExists
      }
      
      return try bw_Wish(
        userId: user.requireID(),
        title: createWishRequest.title,
        description: createWishRequest.description,
        state: createWishRequest.state
      ).save(on: req)
    }.map { savedWish in
      return bw_CreateWishResponse(
        title: savedWish.title,
        description: savedWish.description,
        state: savedWish.state
      )
    }
  }
  
  func vote(req: Request) throws -> Future<bw_SingleWishResponse> {
    return try req.user().flatMap { (user: bw_User) in
      return try req.parameters.next(bw_Wish.self).flatMap { wish in
        return try wish.votingUsers.query(on: req).all().flatMap { votingUsers in
          
          guard wish.userId != (try user.requireID()) else {
            throw bw_WishError.cannotVoteForOwnWish
          }
          
          guard !votingUsers.contains(where: { user.uuid == $0.uuid }) else {
            throw bw_WishError.userAlreadyVoted
          }
          
          return try bw_UserWish(userId: user.requireID(), wishId: wish.requireID()).save(on: req).flatMap { _ in
            
            return try wish.votingUsers.query(on: req).all().map { newVotingUsers in
              return try bw_SingleWishResponse(
                id: wish.requireID(),
                userUUID: user.uuid,
                title: wish.title,
                description: wish.description,
                state: wish.state,
                votingUsers: newVotingUsers.map { bw_SingleUserResponse(uuid: $0.uuid) }
              )
            }
          }
        }
      }
    }
  }
}
