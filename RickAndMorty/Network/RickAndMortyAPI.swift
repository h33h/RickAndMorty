//
//  RickAndMortyAPI.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Moya

enum RickAndMortyAPI {
  case getAllCharacters
  case getCharacters(params: CharacterRequestSettings)
  case getAllLocations
  case getLocations(params: LocationRequestSettings)
  case getAllEpisodes
  case getEpisodes(params: EpisodeRequestSettings)

  var settings: RequestSettings {
    switch self {
    case .getAllCharacters: return CharacterRequestSettings()
    case .getCharacters(let params): return params
    case .getAllLocations: return LocationRequestSettings()
    case .getLocations(let params): return params
    case .getAllEpisodes: return EpisodeRequestSettings()
    case .getEpisodes(let params): return params
    }
  }
}

extension RickAndMortyAPI: TargetType {
  public var baseURL: URL {
    guard let url = URL(string: "https://rickandmortyapi.com") else { fatalError("Сonversion URL error") }
    return url
  }

  public var path: String {
    switch self {
    default: return settings.path()
    }
  }

  public var method: Method { .get }

  public var task: Task {
    switch self {
    case .getAllCharacters, .getAllLocations, .getAllEpisodes: return .requestPlain
    default: return .requestParameters(parameters: settings.parameters, encoding: URLEncoding.queryString)
    }
  }

  public var headers: [String: String]? { ["Content-type": "application/json"] }
}
