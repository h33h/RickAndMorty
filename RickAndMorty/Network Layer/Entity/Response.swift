//
//  Response.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import ObjectMapper

struct Response<Entity: EntityType & Mappable>: Mappable {
  var info: ResponseInfo?
  var results: [Entity] = []

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    info <- map["info"]
    results <- map["results"]
  }
}
