//
//  EntityProvider.swift
//  RickAndMorty
//
//  Created by XXX on 5.06.22.
//

import RxSwift

protocol EntityProvider: AnyObject {
  func getEntities<Entity: EntityType>(of type: Entity.Type, with settings: EntityRequestSettings<Entity>) -> Single<Response<Entity>>
}
