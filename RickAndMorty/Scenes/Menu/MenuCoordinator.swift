//
//  MenuCoordinator.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation
import UIKit

enum MenuTabBarItem: TabBarItem {
  case characters
  case locations
  case episodes
  var content: TabBarItemContent {
    switch self {
    case .characters: return TabBarItemContent(
      title: "Characters",
      image: UIImage(systemName: "person.3") ?? UIImage()
    )
    case .locations: return TabBarItemContent(
      title: "Locations",
      image: UIImage(systemName: "location") ?? UIImage()
    )
    case .episodes: return TabBarItemContent(
      title: "Episodes",
      image: UIImage(systemName: "play.tv") ?? UIImage()
    )
    }
  }
}

class MenuCoordinator: BaseCoordinator, Presentable {
  var viewController: ViewController?
  override func start() {
    let menuViewController: MenuViewController = DIContainer.shared.resolve()
    viewController = menuViewController
    DIContainer.shared.assembler.apply(assemblies: [
      EntityListAssembly<Character>(),
      EntityListAssembly<Location>(),
      EntityListAssembly<Episode>()
    ])
    let characterCoordinator: EntityListCoordinator<Character> = DIContainer.shared.resolve()
    let locationCoordinator: EntityListCoordinator<Location> = DIContainer.shared.resolve()
    let episodeCoordinator: EntityListCoordinator<Episode> = DIContainer.shared.resolve()
    let tabs: [BaseCoordinator & Presentable] = [characterCoordinator, locationCoordinator, episodeCoordinator]
    tabs.forEach { $0.start() }
    menuViewController.setTabs(tabBarItemType: MenuTabBarItem.self, with: tabs.compactMap { $0.viewController })
    navigationController.pushViewController(menuViewController, animated: true)
  }
}
