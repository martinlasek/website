//
//  WishModel.swift
//  App
//
//  Created by Martin Lasek on 05.09.20.
//

import FluentPostgreSQL

protocol WishModel: PostgreSQLModel {
  var state: WishState { get set }
  var title: String { get }
  var description: String { get set }
}
