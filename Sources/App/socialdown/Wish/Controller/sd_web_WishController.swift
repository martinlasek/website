//
//  sd_web_WishController.swift
//  App
//
//  Created by Martin Lasek on 05.09.20.
//

import Vapor

/// SocialDown Web WishController
final class sd_web_WishController {
  private let dispatcher = sd_WishDispatcher()
  
  func renderWishList(req: Request) throws -> Future<View> {
    let listWishRequest = try req.query.decode(ListWishRequest.self)
    
    return dispatcher.list(with: listWishRequest.state, on: req).flatMap { wishList in
      
      let listResponse = try ListWishResponse(
        metaInfo: .create(.wishList, .socialdown, on: req),
        activeTab: listWishRequest.state,
        wishList: wishList.map { try SingleWishResponse.from($0) }
      )
      
      return try req.view().render("AdminPanel/wish-list", listResponse)
    }
  }
  
  func changeState(req: Request) throws -> Future<Response> {
    return try req.parameters.next(socialdown_Wish.self).flatMap { wish in
      return try req.content.decode(ChangeStateRequest.self).flatMap { changeStateRequest in
        
        return self.dispatcher
          .changeState(of: wish, to: changeStateRequest.state, on: req)
          .transform(to: req.redirect(to: "/admin/socialdown/wish/list?state=\(changeStateRequest.state)"))
      }
    }
  }
}
