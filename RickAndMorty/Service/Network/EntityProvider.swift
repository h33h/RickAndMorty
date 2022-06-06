//
//  EntityProvider.swift
//  RickAndMorty
//
//  Created by XXX on 5.06.22.
//

import RxSwift

protocol EntityProvider {
  func getEntities<Entity: EntityType>(entityType: Entity.Type, with settings: Entity.EntityRequest) -> Single<Response<Entity>>
}

