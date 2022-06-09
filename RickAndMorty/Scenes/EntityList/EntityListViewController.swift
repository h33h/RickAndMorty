//
//  EntityListViewController.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

import UIKit
import RxSwift
import RxCocoa

class EntityListViewController<Entity: EntityType>: ListViewController {
  var viewModel: EntityListViewModel<Entity>!
  override func setupUI() {
    super.setupUI()
    registerCell()
  }

  let selectedFilter = BehaviorRelay<FilterType<Entity>>(value: .date(.reverse))

  private func registerCell() {
    collectionView.register(
      UINib(nibName: Entity.CellType.reuseIdentifier, bundle: nil),
      forCellWithReuseIdentifier: Entity.CellType.reuseIdentifier
    )
  }

  override func bindViewModel() {
    super.bindViewModel()
    let collectionReachedNewPage = collectionView.rx.prefetchItems
      .compactMap { $0.last?.row }
      .distinctUntilChanged({ $0 }, comparer: { $0 >= $1 })
      .compactMap { [weak self] prefetchRow -> Void? in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        let itemCount = self.collectionView.numberOfItems(inSection: 0)
        print(prefetchRow, itemCount)
        if itemCount - prefetchRow <= 5 {
          return ()
        }
        return nil
      }
      .emptyDriverIfError()

    let filterChanged = self.selectedFilter.asDriver()
    let input = EntityListViewModel<Entity>.Input(fetchEntitiesTrigger: collectionReachedNewPage,filterChangedTrigger: filterChanged)
    let output = viewModel.transform(input: input)
    output.entities.drive(collectionView.rx.items) { collectionView, row, item in
      let indexPath = IndexPath(row: row, section: .zero)
      let cell: Entity.CellType = DIContainer.shared.resolve(arguments: collectionView, indexPath)
      guard let item = item as? Entity.CellType.Item else { return cell }
      cell.configure(with: item)
      return cell
    }
    .disposed(by: disposeBag)
  }
}
