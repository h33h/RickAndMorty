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
  func getEntities<T: EntityType>(of type: T.Type, on page: Int, with settings: T.RequestType? = nil) -> Single<Response<T>> {
    entityProvider.getEntities(of: type, on: page, with: settings)
      .compactMap { $0.info?.pages }
      .asObservable()
      .asSingle()
      .flatMap { [weak self] pagesCount -> Single<Response<T>> in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        switch self.sortOrder {
        case .forward: return self.entityProvider.getEntities(of: type, on: page, with: settings)
        case .reverse: return self.entityProvider.getEntities(of: type, on: pagesCount - page, with: settings)
            .map {
              var reversedResponse = $0
              reversedResponse.results = reversedResponse.results.reversed()
              return reversedResponse
            }
        }
      }
  }
}
