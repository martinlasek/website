//
//  WishDispatcher.swift
//  App
//
//  Created by Martin Lasek on 05.09.20.
//

import Vapor

protocol WishDispatcher {
  associatedtype Model: WishModel
}

extension WishDispatcher {
  func list(with state: WishState?, on req: Request) -> Future<[Model]> {
    var query = Model.query(on: req)
    if let state = state { query = query.filter(\.state, .equal, state) }
    return query.all()
  }
  
  func changeState(of model: Model, to state: WishState, on req: Request) -> Future<Model> {
    var shadowModel = model
    shadowModel.state = state
    return shadowModel.save(on: req)
  }
}
