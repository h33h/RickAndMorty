//
//  EndPoint.swift
//  RickAndMorty
//
//  Created by XXX on 9.06.22.
//

protocol EndPoint {
  var basePath: String { get }
  var ids: [Int] { get }
  init()
}

extension EndPoint {
  var path: String {
    var path = basePath
    if !ids.isEmpty {
      path.append("/")
      for (index, id) in ids.enumerated() where index < ids.count {
        path.append("\(id),")
      }
      if let lastId = ids.last { path.append("\(lastId)") }
    }
    return path
  }
}
