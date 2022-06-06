//
//  RickAndMortyNetworkService.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import Moya
import RxSwift

class RickAndMortyNetworkService: EntityProvider {
  private let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
  private lazy var provider = MoyaProvider<RickAndMortyAPI>()
  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
  }()

  func getEntities<Entity: EntityType>(entityType: Entity.Type, with settings: Entity.EntityRequest) -> Single<Response<Entity>> {
    provider.rx.request(.getEntities(settings: settings)).map { [weak self] response in
      guard let self = self else { throw NetworkError.serviceUnloaded }
      return try response.map(
        Response<Entity>.self,
        atKeyPath: nil,
        using: self.decoder,
        failsOnEmptyData: true
      )
    }
  }
}
