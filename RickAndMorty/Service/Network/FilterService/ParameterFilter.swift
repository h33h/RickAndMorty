//
//  ParameterFilter.swift
//  RickAndMorty
//
//  Created by XXX on 8.06.22.
//

import RxSwift

class ParameterFilter<Entity: EntityType>: EntityProvider {
  private let entityProvider: EntityProvider
  private let parameter: Entity.ParameterType

  init(entityProvider: EntityProvider, parameter: Entity.ParameterType) {
    self.entityProvider = entityProvider
    self.parameter = parameter
  }

  func getEntities<T: EntityType>(of type: T.Type, on page: Int, with settings: T.RequestType? = nil) -> Single<Response<T>> {
    var settings = T.RequestType(page: page)
    guard let parameter = parameter as? T.RequestType.Item.ParameterType else { return .never() }
    settings.requestParameter = parameter
    return entityProvider.getEntities(of: type, on: page, with: settings)
  }
}
