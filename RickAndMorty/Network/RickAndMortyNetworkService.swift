//
//  RickAndMortyNetworkService.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import Moya
import RxSwift

class RickAndMortyNetworkService<T: EntityType> {
  lazy var provider = MoyaProvider<RickAndMortyAPI>()

  func getEntities(with settings: T.EntityRequest) -> Observable<ProgressResponse> {
    provider.rx.requestWithProgress(.getEntities(settings: settings))
  }
}
