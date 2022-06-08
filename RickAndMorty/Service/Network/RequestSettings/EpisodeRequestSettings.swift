//
//  EpisodeRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

enum EpisodeRequestParameter: RequestParameter {
  case name(String)
  case episode(String)
  var parameter: (title: String, value: Any) {
    switch self {
    case .name(let name): return ("name", name)
    case .episode(let episode): return ("episode", episode)
    }
  }
}

struct EpisodeRequestSettings: RequestSettings {
  var page: Int = 0
  var requestParameter: EpisodeRequestParameter?
  typealias Item = Episode
  var basePath: String = "/episode"
  var ids: [Int] = []
}
