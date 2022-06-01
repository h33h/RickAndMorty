//
//  CharacterRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct CharacterRequestSettings: RequestSettings {
  var basePath: String = "/character"

  var parameters: [String : Any] {
    var requestParams: [String: Any] = [:]
    requestParams["name"] = name
    requestParams["status"] = status
    requestParams["species"] = species
    requestParams["type"] = type
    requestParams["gender"] = gender
    requestParams["page"] = page
    return requestParams
  }

  let ids: [Int]? = nil
  let page: Int? = nil
  let name: String? = nil
  let status: String? = nil
  let species: String? = nil
  let type: String? = nil
  let gender: String? = nil
}
