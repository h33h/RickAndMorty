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
  struct Input {}
  struct Output {}
  private var entityService: EntityProvider?
  private let disposeBag = DisposeBag()
  private(set) var requestSettings: T.EntityRequest?
  let entities: BehaviorRelay<[T]> = BehaviorRelay(value: [])
  let isLoading: PublishSubject<Bool> = PublishSubject()

  weak var coordinator: EntityListCoordinator<T>?

  func transorm(input: Input) -> Output {Output()}

  init(entityService: EntityProvider) {
    self.entityService = entityService
  }

  func updateRequestSettings(with settings: T.EntityRequest) {
    requestSettings = settings
  }

  func getEntities() {
    guard let settings = requestSettings else { return }
    isLoading.onNext(true)
    entityService?.getEntities(entityType: T.self, with: settings)
      .subscribe { [weak self] event in
        guard let self = self else { return }
        switch event {
        case .success(let response):
          self.entities.accept(self.entities.value + response.results)
          self.isLoading.onNext(false)
        case .failure(let error): print(error.localizedDescription)
        }
      }
      .disposed(by: disposeBag)
  }
}
