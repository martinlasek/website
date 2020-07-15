//
//  bw_ListWishResponse.swift
//  App
//
//  Created by Martin Lasek on 06.05.20.
//

import Vapor

struct bw_ListWishResponse: Content {
  let list: [bw_SingleWishResponse]
}
