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
  private enum Constants {
    static var apiUrl = "https://rickandmortyapi.com/api"
    static var contentTypeHeader = "Content-type"
    static var contentTypeValue = "application/json"
  }

  var baseURL: URL { URL(string: Constants.apiUrl)! }

  var path: String { settings.path() }

  var method: Method { .get }

  var task: Task {
    if settings.parameters.isEmpty { return .requestPlain }
    return .requestParameters(parameters: settings.parameters, encoding: URLEncoding.queryString)
  }

  var headers: [String: String]? {
    [Constants.contentTypeHeader: Constants.contentTypeValue]
  }
}
