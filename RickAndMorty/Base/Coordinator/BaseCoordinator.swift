//
//  BaseCoordinator.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import UIKit

class BaseCoordinator: Coordinator {
  var navigationController = UINavigationController()
  var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []

  func start() {
    fatalError("Should be implemented in child coordinators")
  }

  func coordinate(to coordinator: Coordinator) {
    childCoordinators.append(coordinator)
    coordinator.parentCoordinator = self
    coordinator.start()
  }

  func didFinish(coordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
      childCoordinators.remove(at: index)
    }
  }

  func removeChildCoordinators() {
    childCoordinators.forEach { $0.removeChildCoordinators() }
    childCoordinators.removeAll()
  }
}
