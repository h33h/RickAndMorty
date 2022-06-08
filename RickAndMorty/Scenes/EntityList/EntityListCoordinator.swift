//
//  CharacterListCoordinator.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

class EntityListCoordinator<Entity: EntityType>: BaseCoordinator {
  override func start() {
    DIContainer.shared.assembler.apply(assembly: CellAssembly<Entity>())
    let vc: EntityListViewController<Entity> = DIContainer.shared.resolve()
    self.viewController = vc
  }
}
