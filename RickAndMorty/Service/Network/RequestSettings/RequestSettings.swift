//
//  RequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

protocol RequestParameter: Hashable {
  var parameter: (title: String, value: Any) { get }
}

protocol RequestSettings {
  associatedtype Item: EntityType
  var basePath: String { get }
  var ids: [Int] { get set }
  var page: Int { get set }
  var requestParameter: Item.ParameterType? { get set }
  init()
}

extension RequestSettings {
  var path: String {
    var path = basePath
    if !ids.isEmpty {
      path.append("/")
      for (index, id) in ids.enumerated() where index != ids.count {
        path.append("\(id),")
      }
      if let lastID = ids.last { path.append("\(lastID)") }
    }
    return path
  }

  var parameters: [String: Any] {
    var params: [String: Any] = [:]
    params["page"] = page
    guard let parameter = requestParameter?.parameter else { return params }
    params[parameter.title] = parameter.value
    return params
  }

  init(page: Int) {
    self.init()
    self.page = page
  }
}

struct AnyRequestSettings {
  init<Settings: RequestSettings>(_ settings: Settings) {
    path = settings.path
    parameters = settings.parameters
  }
  var path: String
  var parameters: [String: Any]
}
