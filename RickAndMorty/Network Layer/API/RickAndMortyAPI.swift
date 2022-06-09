//
//  RickAndMortyAPI.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Moya

enum RickAndMortyAPI {
  case getEntities(settings: AnyRequestSettings)

  var settings: AnyRequestSettings {
    switch self {
    case .getEntities(let settings): return settings
    }
  }
}

extension RickAndMortyAPI: TargetType {
  private enum Constants {
    static var apiUrl = "https://rickandmortyapi.com/api"
  }

  var baseURL: URL { URL(string: Constants.apiUrl)! }

  var path: String { settings.path }

  var method: Method { .get }

  var task: Task { .requestParameters(parameters: settings.parameters, encoding: URLEncoding.default) }

  var headers: [String: String]? { nil }
}
