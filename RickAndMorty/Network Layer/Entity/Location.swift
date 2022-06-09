//
//  Location.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import ObjectMapper

struct Location: Mappable {
  var id: Int?
  var name: String?
  var type: String?
  var dimension: String?
  var residents: [String?] = []
  var url: String?
  var created: Date?

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    type <- map["type"]
    dimension <- map["dimension"]
    residents <- map["residents"]
    url <- map["url"]
    created <- (map["created"], DateFormatterTransform.rickAndMortyDateFormatter)
  }
}

extension Location: EntityType {
  typealias EndPointType = LocationEndPoint
  typealias ParameterType = LocationRequestParameter
  typealias CellType = LocationCell
}
