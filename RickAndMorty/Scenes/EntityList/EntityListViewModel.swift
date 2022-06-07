//
//  EntityListViewModel.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import RxSwift
import RxRelay
import RxCocoa

class EntityListViewModel<T: EntityType>: ViewModel {
  struct Input {
    let loadTrigger: Driver<Void>
    let fetchTrigger: Driver<T.EntityRequest>
  }
  struct Output {
    let entities: Driver<[T.CellType.Item]>
    let isLoading: Driver<Bool>
  }
  private let entityService: EntityProvider?
  let entities: BehaviorRelay<[T.CellType.Item]> = BehaviorRelay(value: [])
  let isLoading: PublishSubject<Bool> = PublishSubject()

  var coordinator: EntityListCoordinator<T>?

  func transorm(input: Input) -> Output {Output(entities: Observable<[T.CellType.Item]>.empty().emptyDriverIfError(), isLoading: Observable<Bool>.empty().emptyDriverIfError())}

  init(entityService: EntityProvider, coordinator: EntityListCoordinator<T>) {
    self.entityService = entityService
    self.coordinator = coordinator
  }

//  func getEntities() {
//    guard let settings = requestSettings else { return }
//    isLoading.onNext(true)
//    entityService?.getEntities(entityType: T.self, with: settings)
//      .subscribe { [weak self] event in
//        guard let self = self else { return }
//        switch event {
//        case .success(let response):
//          self.entities.accept(self.entities.value + response.results)
//          self.isLoading.onNext(false)
//        case .failure(let error): print(error.localizedDescription)
//        }
//      }
//      .disposed(by: disposeBag)
//  }
}
