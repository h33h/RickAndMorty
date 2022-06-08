//
//  LocationRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

enum LocationRequestParameter: RequestParameter {
  case name(String)
  case type(String)
  case dimension(String)
  var parameter: (title: String, value: Any) {
    switch self {
    case .name(let name): return ("name", name)
    case .type(let type): return ("type", type)
    case .dimension(let dimension): return ("dimension", dimension)
    }
  }
}

struct LocationRequestSettings: RequestSettings {
  var page: Int = 0
  var requestParameter: LocationRequestParameter?
  typealias Item = Location
  var basePath: String = "/location"
  var ids: [Int] = []
}
