//
//  EntityProvider.swift
//  RickAndMorty
//
//  Created by XXX on 5.06.22.
//

import RxSwift

protocol EntityProvider {
  func getEntities<T: EntityType>(of type: T.Type, on page: Int, with settings: T.RequestType?) -> Single<Response<T>>
}
