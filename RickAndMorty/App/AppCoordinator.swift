//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {

  var window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  override func start() {
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}
