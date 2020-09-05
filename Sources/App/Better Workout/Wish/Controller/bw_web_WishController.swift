//
//  bw_web_WishController.swift
//  App
//
//  Created by Martin Lasek on 05.09.20.
//

import Vapor

/// BetterWorkout Web WishController
final class bw_web_WishController {
  private let dispatcher = bw_WishDispatcher()
  
  func renderWishList(req: Request) throws -> Future<View> {
    let listWishRequest = try req.query.decode(ListWishRequest.self)
    
    return dispatcher.list(with: listWishRequest.state, on: req).flatMap { wishList in
      
      let listResponse = try ListWishResponse(
        metaInfo: .create(.wishList, .betterworkout, on: req),
        activeTab: listWishRequest.state,
        wishList: wishList.map { try SingleWishResponse.from($0) }
      )
      
      return try req.view().render("AdminPanel/wish-list", listResponse)
    }
  }
  
  func changeState(req: Request) throws -> Future<Response> {
    return try req.parameters.next(bw_Wish.self).flatMap { wish in
      return try req.content.decode(ChangeStateRequest.self).flatMap { changeStateRequest in
        
        return self.dispatcher
          .changeState(of: wish, to: changeStateRequest.state, on: req)
          .transform(to: req.redirect(to: "/admin/betterworkout/wish/list?state=\(changeStateRequest.state)"))
      }
    }
  }
}
