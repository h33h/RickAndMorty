//
//  AppAssembly.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Swinject

class AppAssembly: Assembly {
  func assemble(container: Container) {
    container.register(AppCoordinator.self) { resolver, window in
      AppCoordinator(window: window)
    }
  }
}
