//
//  ParameterFilter.swift
//  RickAndMorty
//
//  Created by XXX on 8.06.22.
//

import RxSwift

class ParameterFilter<Entity: EntityType>: EntityProvider {
  private let entityProvider: EntityProvider
  private let parameters: [Entity.ParameterType]

  init(entityProvider: EntityProvider, parameters: [Entity.ParameterType]) {
    self.entityProvider = entityProvider
    self.parameters = parameters
  }

  func getEntities<Entity: EntityType>(
    of type: Entity.Type,
    with settings: EntityRequestSettings<Entity>
  ) -> Single<Response<Entity>> {
    if let parameters = parameters as? [Entity.ParameterType] {
      settings.parameters = parameters
    }
    return entityProvider.getEntities(of: type, with: settings)
  }
}
