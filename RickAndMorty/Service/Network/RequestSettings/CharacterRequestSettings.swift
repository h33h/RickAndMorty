//
//  CharacterRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

enum CharacterRequestParameter: RequestParameter {
  case name(String)
  case status(LifeStatus)
  case species(String)
  case type(String)
  case gender(GenderStatus)
  var parameter: (title: String, value: Any) {
    switch self {
    case .name(let name): return ("name", name)
    case .status(let lifeStatus): return ("status", lifeStatus.rawValue)
    case .species(let species): return ("species", species)
    case .type(let type): return ("type", type)
    case .gender(let genderStatus): return ("gender", genderStatus.rawValue)
    }
  }
}

struct CharacterRequestSettings: RequestSettings {
  var page: Int = 0
  var requestParameter: CharacterRequestParameter?
  typealias Item = Character
  var basePath: String = "/character"
  var ids: [Int] = []
}
