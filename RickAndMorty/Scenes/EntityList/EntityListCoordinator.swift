//
//  EntityListCoordinator.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import UIKit

class EntityListCoordinator<T: EntityType>: BaseCoordinator, Presentable {
  var viewController: ViewController?

  override func start() {
    DIContainer.shared.assembler.apply(assembly: CellAssembly<T>())
    let viewController: EntityListViewController<T> = DIContainer.shared.resolve()
    self.viewController = viewController
  }
}
