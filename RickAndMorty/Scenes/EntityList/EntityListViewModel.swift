//
//  EntityListViewModel.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import RxSwift

class EntityListViewModel<T: EntityType> {
  private lazy var service: RickAndMortyNetworkService<T> = { RickAndMortyNetworkService<T>() }()
  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
  }()
  private let disposeBag = DisposeBag()
  let entities: PublishSubject<[T]> = PublishSubject()
  let loadingProgress: PublishSubject<Double> = PublishSubject()
  let isLoading: PublishSubject<Bool> = PublishSubject()
  func getEntities(with config: T.EntityRequest) {
    isLoading.onNext(true)
    service.getEntities(with: config)
      .observe(on: MainScheduler.instance)
      .subscribe { [weak self] event in
        guard let self = self else { return }
        switch event {
        case .next(let progressResponse):
          if let response = progressResponse.response {
            do {
            let decoded = try response.map(
              Response<T>.self,
              atKeyPath: nil,
              using: self.decoder,
              failsOnEmptyData: true)
            self.entities.onNext(decoded.results)
            } catch {
              print(error.localizedDescription)
            }
            self.loadingProgress.onNext(Double.zero)
            self.isLoading.onNext(false)
          } else {
            self.loadingProgress.onNext(progressResponse.progress)
          }
        case .error(let error): print(error.localizedDescription)
        default: break
        }
      }
      .disposed(by: disposeBag)
  }
}
