//
//  Location.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct Location: Codable {
  let id: Int
  let name: String
  let type: String
  let dimension: String
  @OptionalCodable var residents: [URL?]?
  @OptionalCodable var url: URL?
  let created: Date
}

extension Location: EntityType {
  typealias EntityRequest = LocationRequestSettings
  typealias CellType = LocationCell
}
