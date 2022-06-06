//
//  CellAssembly.swift
//  RickAndMorty
//
//  Created by XXX on 2.06.22.
//

import Swinject

class CellAssembly<T: EntityType>: Assembly {
  func assemble(container: Container) {
    container.register(ImageProvider.self) { _ in ImageService() }.inObjectScope(.container)
    container.register(ImageProvider.self, name: "proxy") { resolver in
      guard let imageService = resolver.resolve(ImageProvider.self) else { fatalError("Image service not found") }
      return ImageProxyService(imageService: imageService)
    }
    container.register(T.CellType.self) { (_, collectionView: UICollectionView, indexPath: IndexPath) in
      guard
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: T.CellType.reuseIdentifier,
          for: indexPath) as? T.CellType
      else { fatalError("Creating cell error") }
      return cell
    }
    .initCompleted { resolver, cell in
      if cell is CharacterCell, let cell = cell as? CharacterCell {
        cell.imageService = resolver.resolve(ImageProvider.self)
      }
    }
  }
}
