//
//  LocationRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct LocationRequestSettings: RequestSettings {
  let basePath: String = "/location"

  var parameters: [String : Any] {
    var requestParams: [String: Any] = [:]
    requestParams["name"] = name
    requestParams["type"] = type
    requestParams["dimension"] = dimension
    return requestParams
  }

  let ids: [Int]? = nil
  let name: String? = nil
  let type: String? = nil
  let dimension: String? = nil
}
