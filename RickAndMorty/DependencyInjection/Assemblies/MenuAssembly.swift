//
//  MenuAssembly.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Swinject

class MenuAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MenuViewModel.self) { _ in MenuViewModel() }
    container.register(MenuViewController.self) { _ in MenuViewController() }
      .initCompleted { _, viewController in
        viewController.viewModel = container.resolve(MenuViewModel.self)
      }
    container.register(MenuCoordinator.self) { _ in MenuCoordinator() }
      .initCompleted { resolver, coordinator in
        resolver.resolve(MenuViewModel.self)?.coordinator = coordinator
      }
  }
}
