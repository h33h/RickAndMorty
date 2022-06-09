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

  func getEntities<Entity: EntityType>(
    of type: Entity.Type,
    with settings: EntityRequestSettings<Entity>
  ) -> Single<Response<Entity>> {
    provider
      .rx
      .request(.getEntities(settings: AnyRequestSettings(settings)))
      .mapJSON()
      .mapObject(type: Response<Entity>.self)
  }
}
