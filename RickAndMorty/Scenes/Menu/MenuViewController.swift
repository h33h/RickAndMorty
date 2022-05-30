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
    case .characters: return TabBarItemContent(title: "Characters", imageName: "person.3")
    case .locations: return TabBarItemContent(title: "Locations", imageName: "location")
    case .episodes: return TabBarItemContent(title: "Episodes", imageName: "play.tv")
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
