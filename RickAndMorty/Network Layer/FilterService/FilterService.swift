//
//  FilterService.swift
//  RickAndMorty
//
//  Created by XXX on 8.06.22.
//

import RxSwift

class FilterService<Entity: EntityType>: EntityProvider {
  private var entityProvider: EntityProvider
  private(set) var filter: EntityProvider
  init(entityProvider: EntityProvider, filterType: FilterType<Entity>) {
    self.entityProvider = entityProvider
    self.filter = entityProvider
    updateFilter(with: filterType)
  }

  func updateFilter(with filterType: FilterType<Entity>) {
    switch filterType {
    case .none:
      filter = entityProvider
    case .date(let order):
      filter = DateFilter(entityProvider: entityProvider, sortOrder: order)
    case .parameter(let parameters):
      filter = ParameterFilter<Entity>(entityProvider: entityProvider, parameters: parameters)
    }
  }

  func getEntities<Entity: EntityType>(
    of type: Entity.Type,
    with settings: EntityRequestSettings<Entity>
  ) -> Single<Response<Entity>> {
    filter.getEntities(of: type, with: settings)
  }
}
