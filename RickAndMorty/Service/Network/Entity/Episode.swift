//
//  Episode.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import ObjectMapper

struct Episode: Mappable {
  var id: Int?
  var name: String?
  var airDate: String?
  var episode: String?
  var characters: [String?] = []
  var url: String?
  var created: Date?

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    airDate <- map["air_date"]
    episode <- map["episode"]
    characters <- map["characters"]
    url <- map["url"]
    created <- (map["created"], DateFormatterTransform.rickAndMortyDateFormatter)
  }
}

extension Episode: EntityType {
  typealias RequestType = EpisodeRequestSettings
  typealias ParameterType = EpisodeRequestParameter
  typealias CellType = EpisodeCell
}
