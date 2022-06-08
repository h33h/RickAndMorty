//
//  FilterService.swift
//  RickAndMorty
//
//  Created by XXX on 8.06.22.
//

import RxSwift

class FilterService<Entity: EntityType>: EntityProvider {
  private var entityProvider: EntityProvider
  private(set) var filterType: FilterType<Entity>
  private(set) var filter: EntityProvider
  init(entityProvider: EntityProvider, filterType: FilterType<Entity>) {
    self.entityProvider = entityProvider
    self.filterType = filterType
    switch filterType {
    case .none: filter = entityProvider
    case .date(let order): filter = DateFilter(entityProvider: entityProvider, sortOrder: order)
    case .parameter(let parameter): filter = ParameterFilter<Entity>(entityProvider: entityProvider, parameter: parameter)
    }
  }

  func updateFilter(with filterType: FilterType<Entity>) {
    self.filterType = filterType
    switch filterType {
    case .none: filter = entityProvider
    case .date(let order): filter = DateFilter(entityProvider: entityProvider, sortOrder: order)
    case .parameter(let parameter): filter = ParameterFilter<Entity>(entityProvider: entityProvider, parameter: parameter)
    }
  }

  func getEntities<T: EntityType>(of type: T.Type, on page: Int, with settings: T.RequestType? = nil) -> Single<Response<T>> {
    filter.getEntities(of: type, on: page, with: settings)
  }
}
