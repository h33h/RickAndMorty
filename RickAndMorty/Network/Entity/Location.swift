//
//  Location.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct Location: Codable, EntityType {
  typealias EntityRequest = LocationRequestSettings
  let id: Int
  let name: String
  let type: String
  let dimension: String
  let residents: [URL]
  let url: URL
  let created: Date
}
