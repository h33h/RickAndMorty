//
//  EntityListViewModel.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

import RxSwift
import RxCocoa

class EntityListViewModel<Entity: EntityType>: ViewModel {
  struct Input {
    let fetchEntities: Driver<(Int, FilterType<Entity>)>
  }

  struct Output {
    let entities: Driver<[Entity]>
    let isLoading: Driver<Bool>
  }

  init(filterService: FilterService<Entity>) {
    self.filterService = filterService
  }

  let filterService: FilterService<Entity>
  var coordinator: EntityListCoordinator<Entity>?
  let isLoading = PublishRelay<Bool>()
  let results = BehaviorRelay<[Entity]>(value: [])

  func transform(input: Input) -> Output {
    let entities = input.fetchEntities.asObservable()
      .flatMapLatest { [weak self] page, filter -> Single<[Entity]> in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        self.isLoading.accept(true)
        if filter != self.filterService.filterType {
          self.results.accept([])
          self.filterService.updateFilter(with: filter)
        }
        return self.filterService.getEntities(of: Entity.self, on: page)
          .map {
            self.isLoading.accept(false)
            return $0.results
          }
      }
      .map { newEntities -> [Entity] in
        let result = self.results.value + newEntities
        self.results.accept(result)
        return result
      }
      .emptyDriverIfError()
    let isLoading = isLoading.emptyDriverIfError()
    return Output(entities: entities, isLoading: isLoading)
  }
}
