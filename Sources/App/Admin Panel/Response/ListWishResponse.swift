//
//  ListWishResponse.swift
//  App
//
//  Created by Martin Lasek on 04.07.20.
//

struct ListWishResponse: Encodable {
  let metaInfo: MetaInfo
  let activeTab: WishState?
  let wishList: [SingleWishResponse]
}
