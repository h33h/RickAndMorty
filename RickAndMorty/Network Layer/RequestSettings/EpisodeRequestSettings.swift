//
//  EpisodeRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

enum EpisodeRequestParameter: RequestParameter {
  case name(String)
  case episode(String)
  var parameter: [String: Any] {
    switch self {
    case .name(let name): return ["name": name]
    case .episode(let episode): return ["episode": episode]
    }
  }
}

struct EpisodeEndPoint: EndPoint {
  let basePath: String = "/episode"
  var ids: [Int] = []
}
