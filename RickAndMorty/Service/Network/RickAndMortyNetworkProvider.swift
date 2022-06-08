//
//  RickAndMortyNetworkProvider.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import Moya
import RxSwift

class RickAndMortyNetworkProvider: EntityProvider {
  private lazy var provider = MoyaProvider<RickAndMortyAPI>()

  func getEntities<T: EntityType>(of type: T.Type, on page: Int, with settings: T.RequestType? = nil) -> Single<Response<T>> {
    if let settings = settings {
      return provider.rx.request(.getEntities(settings: AnyRequestSettings(settings))).mapJSON().mapObject(type: Response<T>.self)
    }
    return provider.rx.request(.getEntities(settings: AnyRequestSettings(T.RequestType(page: page)))).mapJSON().mapObject(type: Response<T>.self)
  }
}
