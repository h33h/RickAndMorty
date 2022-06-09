//
//  RequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

protocol RequestSettings {
  associatedtype Entity: EntityType
  var endpoint: Entity.EndPointType { get set }
  var parameters: [Entity.ParameterType] { get set }
  var page: Int { get set }
  init()
}

extension RequestSettings {
  var parameters: [String: Any] {
    var parameters: [String: Any] = [:]
    self.parameters.forEach { $0.parameter.forEach { key, value in parameters[key] = value } }
    parameters["page"] = page
    return parameters
  }

  init(page: Int) {
    self.init()
    self.page = page
  }
}

struct AnyRequestSettings {
  init<Settings: RequestSettings>(_ settings: Settings) {
    path = settings.endpoint.path
    parameters = settings.parameters
  }
  var path: String
  var parameters: [String: Any]
}
