//
//  RequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import Foundation

protocol RequestSettings {
  var basePath: String { get }
  var ids: [Int]? { get }
  var parameters: [String: Any] { get }
}

extension RequestSettings {
  func path() -> String {
    var path = basePath
    if let ids = ids {
      path.append("/")
      for (index, id) in ids.enumerated() where index != ids.count {
        path.append("\(id),")
      }
      if let lastID = ids.last { path.append("\(lastID)") }
    }
    return path
  }
}
