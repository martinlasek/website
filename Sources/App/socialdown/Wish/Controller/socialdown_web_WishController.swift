//
//  socialdown_web_WishController.swift
//  App
//
//  Created by Martin Lasek on 05.09.20.
//

import Vapor

final class socialdown_web_WishController {
  
  func renderWishList(req: Request) throws -> Future<View> {
    let listWishRequest = try req.query.decode(ListWishRequest.self)
    
    var query = socialdown_Wish.query(on: req)
    
    if let state = listWishRequest.state {
      query = query.filter(\.state, .equal, state)
    }
    
    return query.all().flatMap { wishList in
      
      let listResponse = try ListWishResponse(
        metaInfo: .create(.wishList, on: req),
        activeTab: listWishRequest.state,
        wishList: wishList.map { try SingleWishResponse.from($0) }
      )
      
      return try req.view().render("AdminPanel/wish-list", listResponse)
    }
  }
  
  func changeState(req: Request) throws -> Future<Response> {
    return try req.parameters.next(socialdown_Wish.self).flatMap { wish in
      return try req.content.decode(ChangeStateRequest.self).flatMap { changeStateRequest in
        
        wish.state = changeStateRequest.state
        return wish
          .save(on: req)
          .transform(to: req.redirect(to: "/admin/wish/list?state=\(changeStateRequest.state)"))
      }
    }
  }
}
