//
//  MenuCoordinator.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation

class MenuCoordinator: BaseCoordinator {
  override func start() {
    let menuViewController: MenuViewController = DIContainer.shared.resolve()
    navigationController.pushViewController(menuViewController, animated: true)
  }
}
