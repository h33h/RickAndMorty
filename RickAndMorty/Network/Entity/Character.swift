//
//  Character.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

enum LifeStatus: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown
}

enum GenderStatus: String, Codable {
  case female = "Female"
  case male = "Male"
  case genderless = "Genderless"
  case unknown
}

struct Character: Codable {
  let id: Int
  let name: String
  let status: LifeStatus
  let species: String
  let type: String
  let gender: GenderStatus
  let origin: CharacterLocation
  let location: CharacterLocation
  @OptionalCodable var image: URL?
  @OptionalCodable var episode: [URL?]?
  @OptionalCodable var url: URL?
  let created: Date
}

struct CharacterLocation: Codable {
  let name: String
  @OptionalCodable var url: URL?
}

extension Character: EntityType {
  typealias EntityRequest = CharacterRequestSettings
  typealias CellType = CharacterCell
}
