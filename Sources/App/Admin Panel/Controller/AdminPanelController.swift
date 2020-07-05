//
//  AdminPanelController.swift
//  App
//
//  Created by Martin Lasek on 03.07.20.
//

import Vapor
import Crypto

final class AdminPanelController {
  
  // MARK: - View
  
  func renderRegister(req: Request) throws -> Future<View> {
    let registerResponse = try RegisterResponse(userInfo: .create(.register, on: req))
    return try req.view().render("AdminPanel/register", registerResponse)
  }
  
  func renderLogin(req: Request) throws -> Future<View> {
    let loginResponse = try LoginResponse(userInfo: .create(.login, on: req))
    return try req.view().render("AdminPanel/login", loginResponse)
  }
  
  func renderIndex(req: Request) throws -> Future<View> {
    let indexResponse = try IndexResponse(userInfo: .create(.index, on: req))
    return try req.view().render("AdminPanel/index", indexResponse)
  }
  
  func renderWishList(req: Request) throws -> Future<View> {
    let listWishRequest = try req.query.decode(ListWishRequest.self)
    
    var query = socialdown_Wish.query(on: req)
    
    if let state = listWishRequest.state {
      query = query.filter(\.state, .equal, state)
    }
    
    return query.all().flatMap { wishList in
      
      let listResponse = try ListWishResponse(
        userInfo: .create(.wishList, on: req),
        activeTab: listWishRequest.state,
        wishList: wishList.map { try SingleWishResponse.from($0) }
      )
      
      return try req.view().render("AdminPanel/wish-list", listResponse)
    }
  }
  
  // MARK: - Logic
  
  func register(req: Request) throws -> Future<Response> {
    return AdminUser.query(on: req).count().flatMap { count in
      
      // Only allow 1 registered admin user.
      if count > 0 { return req.future(req.redirect(to: "/admin/register")) }
      
      return try req.content.decode(CreateAdminUserForm.self).flatMap { createForm in
        
        return AdminUser
          .query(on: req)
          .filter(\.username, .equal, createForm.username)
          .count()
          .map { count in (createForm, count) }
        
      }.flatMap { createForm, count in
        
        // Only allow unique usernames.
        if count > 0 { return req.future(req.redirect(to: "/admin/register")) }
        
        let hasher = try req.make(BCryptDigest.self)
        let adminUser = AdminUser(
          username: createForm.username,
          password: try hasher.hash(createForm.password)
        )
        
        return adminUser
          .save(on: req)
          .transform(to: req.redirect(to: "/admin/login"))
      }
    }
  }
  
  func login(req: Request) throws -> Future<Response> {
    return try req.content.decode(LoginAdminUserForm.self).flatMap { loginForm in
      let hasher = try req.make(BCryptDigest.self)
      
      return AdminUser.authenticate(
          username: loginForm.username,
          password: loginForm.password,
          using: hasher,
          on: req
      ).map { user in
        guard let user = user else {
          return req.redirect(to: "/admin/login")
        }
        try req.authenticateSession(user)
        return req.redirect(to: "/admin")
      }
    }
  }
  
  func logout(req: Request) throws -> Future<View> {
    fatalError()
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
