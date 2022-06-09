//
//  LocationRequestParameter.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

enum LocationRequestParameter: RequestParameter {
  case name(String)
  case type(String)
  case dimension(String)
  var parameter: [String: Any] {
    switch self {
    case .name(let name): return ["name": name]
    case .type(let type): return ["type": type]
    case .dimension(let dimension): return ["dimension": dimension]
    }
  }
}

struct LocationEndPoint: EndPoint {
  let basePath: String = "/location"
  var ids: [Int] = []
}
