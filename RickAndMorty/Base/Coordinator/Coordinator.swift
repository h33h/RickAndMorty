//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import UIKit

protocol Coordinator: AnyObject, Presentable {
  var navigationController: UINavigationController { get set }
  var parentCoordinator: Coordinator? { get set }

  func start()
  func coordinate(to coordinator: Coordinator)
  func didFinish(coordinator: Coordinator)
  func removeChildCoordinators()
}
