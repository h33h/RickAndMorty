//
//  DateFilter.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

import RxSwift

class DateFilter: EntityProvider {
  private let entityProvider: EntityProvider
  private let sortOrder: SortOrder

  init(entityProvider: EntityProvider, sortOrder: SortOrder) {
    self.entityProvider = entityProvider
    self.sortOrder = sortOrder
  }

  func getEntities<Entity: EntityType>(
    of type: Entity.Type,
    with settings: EntityRequestSettings<Entity>
  ) -> Single<Response<Entity>> {
    entityProvider.getEntities(of: type, with: settings)
      .compactMap { $0.info?.pages }
      .asObservable()
      .asSingle()
      .flatMap { [weak self] pagesCount -> Single<Response<Entity>> in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        switch self.sortOrder {
        case .forward:
          return self.entityProvider.getEntities(of: type, with: settings)
        case .reverse:
          settings.page = pagesCount - settings.page + 1
          return self.entityProvider.getEntities(of: type, with: settings)
            .map {
              var reversedResponse = $0
              reversedResponse.results = reversedResponse.results.reversed()
              return reversedResponse
            }
        }
      }
  }
}
