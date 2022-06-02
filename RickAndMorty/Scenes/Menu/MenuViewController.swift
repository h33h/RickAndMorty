//
//  MenuViewController.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import UIKit
import SnapKit

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

class MenuViewController: UIViewController, Storyboarded {
  @IBOutlet var tabBarControllerView: UIView!
  lazy var menuTabBarController: TabBarController<MenuTabBarItem> = { TabBarController<MenuTabBarItem>()
  }()
  var viewModel: MenuViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    tabBarControllerView.addSubview(menuTabBarController.view)
    menuTabBarController.view.snp.makeConstraints { make in
      make.edges.equalTo(tabBarControllerView.snp.edges)
    }
  }

  @IBAction func sortButtonTapped(_ sender: Any) {
    
  }
}
