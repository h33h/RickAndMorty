//
//  RequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

protocol RequestSettings {
  var basePath: String { get }
  var page: Int { get set }
  var ids: [Int] { get set }
  var parameters: [String: Any] { get }
  init()
}

extension RequestSettings {
  func path() -> String {
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
}
