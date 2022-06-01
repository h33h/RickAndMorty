//
//  EntityType.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import Foundation

protocol EntityType: Codable {
  associatedtype EntityRequest: RequestSettings
  associatedtype CellType: CellConfigurable
}
