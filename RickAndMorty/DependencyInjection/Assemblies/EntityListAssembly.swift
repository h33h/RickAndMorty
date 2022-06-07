//
//  EntityListAssembly.swift
//  RickAndMorty
//
//  Created by XXX on 2.06.22.
//

import Swinject

class EntityListAssembly<T: EntityType>: Assembly {
  func assemble(container: Container) {
    container.register(EntityProvider.self) { _ in RickAndMortyNetworkService() }.inObjectScope(.container)
    container.register(EntityListCoordinator<T>.self) { _ in EntityListCoordinator<T>() }
    container.register(EntityListViewModel<T>.self) { resolver in
      guard let service = resolver.resolve(EntityProvider.self), let coordinator = resolver.resolve(EntityListCoordinator<T>.self) else {
        fatalError("Error loading entityService")
      }
      let viewModel = EntityListViewModel<T>(entityService: service, coordinator: coordinator)
      return viewModel
    }
    container.register(EntityListViewController<T>.self) { resolver in
      let entityViewController = EntityListViewController<T>()
      entityViewController.viewModel = resolver.resolve(EntityListViewModel<T>.self)
      return entityViewController
    }
  }
}
