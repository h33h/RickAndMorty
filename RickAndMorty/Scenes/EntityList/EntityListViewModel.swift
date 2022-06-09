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
    let fetchEntitiesTrigger: Driver<Void>
    let filterChangedTrigger: Driver<FilterType<Entity>>
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
  let currentPage = BehaviorRelay<Int>(value: 1)

  func transform(input: Input) -> Output {
    let fetchEntities = input.fetchEntitiesTrigger.asObservable()
      .flatMapLatest { [weak self] _ -> Driver<[Entity]> in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        self.isLoading.accept(true)
        let settings = EntityRequestSettings<Entity>(page: self.currentPage.value)
        return self.filterService.getEntities(of: Entity.self, with: settings)
          .map { $0.results }
          .map { newEntities in
            let previousEntities = self.results.value
            let previousPage = self.currentPage.value
            let result = previousEntities + newEntities
            self.results.accept(result)
            self.currentPage.accept(previousPage + 1)
            self.isLoading.accept(false)
            return result
          }
          .asObservable()
          .emptyDriverIfError()
      }
      .emptyDriverIfError()

    let filterChanged = input.filterChangedTrigger.asObservable()
      .flatMapLatest { [weak self] newFilter -> Driver<[Entity]> in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        self.currentPage.accept(1)
        self.results.accept([])
        self.filterService.updateFilter(with: newFilter)
        self.isLoading.accept(true)
        let settings = EntityRequestSettings<Entity>(page: self.currentPage.value)
        return self.filterService.getEntities(of: Entity.self, with: settings)
          .map { $0.results }
          .map { newEntities in
            let previousEntities = self.results.value
            let previousPage = self.currentPage.value
            let result = previousEntities + newEntities
            self.results.accept(result)
            self.currentPage.accept(previousPage + 1)
            self.isLoading.accept(false)
            return result
          }
          .asObservable()
          .emptyDriverIfError()
      }
      .emptyDriverIfError()

    let isLoading = isLoading.emptyDriverIfError()
    return Output(entities: Driver.merge(fetchEntities, filterChanged), isLoading: isLoading)
  }
}
