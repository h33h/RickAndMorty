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
      image: UIImage(systemName: "person.3") ?? UIImage(),
      tintColor: .appCyan,
      backgroundColor: .appGreen
    )
    case .locations: return TabBarItemContent(
      title: "Locations",
      image: UIImage(systemName: "location") ?? UIImage(),
      tintColor: .appCyan,
      backgroundColor: .appGreen
    )
    case .episodes: return TabBarItemContent(
      title: "Episodes",
      image: UIImage(systemName: "play.tv") ?? UIImage(),
      tintColor: .appCyan,
      backgroundColor: .appGreen
    )
    }
  }
}

class MenuCoordinator: BaseCoordinator {
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
    [characterCoordinator, locationCoordinator, episodeCoordinator].forEach { coordinate(to: $0) }
    var tabs: [(MenuTabBarItem, Presentable)] = []
    tabs.append((.characters, characterCoordinator))
    tabs.append((.locations, locationCoordinator))
    tabs.append((.episodes, episodeCoordinator))
    menuViewController.setTabs(tabs)
    navigationController.pushViewController(menuViewController, animated: true)
  }
}
