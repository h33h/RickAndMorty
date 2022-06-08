//
//  FilterType.swift
//  RickAndMorty
//
//  Created by XXX on 8.06.22.
//

import Foundation

enum FilterType<Entity: EntityType>: Equatable {
  case none
  case date(SortOrder)
  case parameter(Entity.ParameterType)
}
