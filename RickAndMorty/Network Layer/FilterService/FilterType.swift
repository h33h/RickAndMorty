//
//  FilterType.swift
//  RickAndMorty
//
//  Created by XXX on 8.06.22.
//

import Foundation

enum FilterType<Entity: EntityType> {
  case none
  case date(SortOrder)
  case parameter([Entity.ParameterType])
}
