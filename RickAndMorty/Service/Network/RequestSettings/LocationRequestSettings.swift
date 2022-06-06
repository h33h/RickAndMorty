//
//  LocationRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

struct LocationRequestSettings: RequestSettings {
  let basePath = "/location"

  var parameters: [String: Any] {
    var requestParams: [String: Any] = [:]
    requestParams["name"] = name
    requestParams["type"] = type
    requestParams["dimension"] = dimension
    requestParams["page"] = page
    return requestParams
  }

  var ids: [Int] = []
  var page: Int = 1
  var name: String? = nil
  var type: String? = nil
  var dimension: String? = nil
}
