//
//  ResponseInfo.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import ObjectMapper

struct ResponseInfo: Mappable {
  var count: Int?
  var pages: Int?
  var next: String?
  var prev: String?

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    count <- map["count"]
    pages <- map["pages"]
    next <- map["next"]
    prev <- map["prev"]
  }
}
