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
    container.register(MenuViewController.self) { _ in MenuViewController.instantiate() }
      .initCompleted { resolver, viewController in
        viewController.viewModel = container.resolve(MenuViewModel.self)
    }
    container.register(MenuCoordinator.self) { _ in MenuCoordinator() }
  }
}
