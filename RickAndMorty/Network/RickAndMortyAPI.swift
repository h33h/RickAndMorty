//
//  RickAndMortyAPI.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Moya

enum RickAndMortyAPI {
  case getEntities(settings: RequestSettings)

  var settings: RequestSettings {
    switch self {
    case .getEntities(let settings): return settings
    }
  }
}

extension RickAndMortyAPI: TargetType {
  public var baseURL: URL {
    guard let url = URL(string: "https://rickandmortyapi.com") else { fatalError("Сonversion URL error") }
    return url
  }

  public var path: String { settings.path() }

  public var method: Method { .get }

  public var task: Task {
    if settings.parameters.isEmpty { return .requestPlain }
    return .requestParameters(parameters: settings.parameters, encoding: URLEncoding.queryString)
  }

  public var headers: [String: String]? { ["Content-type": "application/json"] }
}
