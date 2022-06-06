//
//  CharacterRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

struct CharacterRequestSettings: RequestSettings {
  let basePath = "/character"

  var parameters: [String: Any] {
    var requestParams: [String: Any] = [:]
    requestParams["name"] = name
    requestParams["status"] = status
    requestParams["species"] = species
    requestParams["type"] = type
    requestParams["gender"] = gender
    requestParams["page"] = page
    return requestParams
  }

  var ids: [Int] = []
  var page: Int = 1
  var name: String? = nil
  var status: String? = nil
  var species: String? = nil
  var type: String? = nil
  var gender: String? = nil
}
