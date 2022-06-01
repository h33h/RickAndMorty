//
//  MenuCoordinator.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation
import UIKit

class MenuCoordinator: BaseCoordinator {
  override func start() {
    let menuViewController: MenuViewController = DIContainer.shared.resolve()
    let viewModel = EntityListViewModel<Character>()
    let vc = EntityListViewController<Character>()
    vc.viewModel = viewModel
    menuViewController.menuTabBarController.setViewControllers([vc])
    navigationController.pushViewController(menuViewController, animated: true)
    viewModel.getEntities(with: CharacterRequestSettings())
  }
}
