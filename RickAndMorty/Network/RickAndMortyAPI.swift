//
//  RickAndMortyAPI.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Moya

enum RickAndMortyAPI {
  case getAllCharacters
  case getCharacters(params: CharacterRequestParams)
  case getAllLocations
  case getLocations(params: LocationRequestParams)
  case getAllEpisodes
  case getEpisodes(params: EpisodeRequestParams)
}

extension RickAndMortyAPI: TargetType {
  public var baseURL: URL {
    guard let url = URL(string: "https://rickandmortyapi.com") else { fatalError("Сonversion URL error") }
    return url
  }

  public var path: String {
    switch self {
    case .getAllCharacters: return "/character"
    case let .getCharacters(params):
      var path = "/character"
      if let ids = params.ids {
        path.append("/")
        ids.forEach { path.append("\($0),") }
      }
      return path
    case .getAllLocations: return "/location"
    case let .getLocations(params):
      var path = "/location"
      if let ids = params.ids {
        path.append("/")
        ids.forEach { path.append("\($0),") }
      }
      return path
    case .getAllEpisodes: return "/episode"
    case let .getEpisodes(params):
      var path = "/episode"
      if let ids = params.ids {
        path.append("/")
        ids.forEach { path.append("\($0),") }
      }
      return path
    }
  }

  public var method: Method { .get }

  public var task: Task {
    switch self {
    case .getAllCharacters, .getAllLocations, .getAllEpisodes: return .requestPlain
    case let .getCharacters(params):
      var requestParams: [String: Any] = [:]
      requestParams["name"] = params.name
      requestParams["status"] = params.status
      requestParams["species"] = params.species
      requestParams["type"] = params.type
      requestParams["gender"] = params.gender
      return .requestParameters(parameters: requestParams, encoding: URLEncoding.queryString)
    case let .getLocations(params):
      var requestParams: [String: Any] = [:]
      requestParams["name"] = params.name
      requestParams["type"] = params.type
      requestParams["dimension"] = params.dimension
      return .requestParameters(parameters: requestParams, encoding: URLEncoding.queryString)
    case let .getEpisodes(params):
      var requestParams: [String: Any] = [:]
      requestParams["name"] = params.name
      requestParams["episode"] = params.episode
      return .requestParameters(parameters: requestParams, encoding: URLEncoding.queryString)
    }
  }

  public var headers: [String: String]? { ["Content-type": "application/json"] }
}
