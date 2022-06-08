//
//  Character.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import ObjectMapper

enum LifeStatus: String {
  case alive = "Alive"
  case dead = "Dead"
  case unknown
}

enum GenderStatus: String {
  case female = "Female"
  case male = "Male"
  case genderless = "Genderless"
  case unknown
}

struct Character: Mappable {
  var id: Int?
  var name: String?
  var status: LifeStatus?
  var species: String?
  var type: String?
  var gender: GenderStatus?
  var origin: CharacterLocation?
  var location: CharacterLocation?
  var image: String?
  var episode: [String?] = []
  var url: String?
  var created: Date?

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    status <- map["status"]
    species <- map["species"]
    type <- map["type"]
    gender <- map["gender"]
    origin <- map["origin"]
    location <- map["location"]
    image <- map["image"]
    episode <- map["episode"]
    url <- map["url"]
    created <- (map["created"], DateFormatterTransform.rickAndMortyDateFormatter)
  }
}

struct CharacterLocation: Mappable {
  var name: String?
  var url: URL?

  init?(map: Map) { }

  mutating func mapping(map: Map) {
    name <- map["name"]
    url <- map["url"]
  }
}

extension Character: EntityType {
  typealias RequestType = CharacterRequestSettings
  typealias ParameterType = CharacterRequestParameter
  typealias CellType = CharacterCell
}
