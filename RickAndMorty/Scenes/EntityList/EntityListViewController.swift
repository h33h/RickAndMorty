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

  let selectedFilter = BehaviorRelay<FilterType<Entity>>(value: .none)

  private func registerCell() {
    collectionView.register(
      UINib(nibName: Entity.CellType.reuseIdentifier, bundle: nil),
      forCellWithReuseIdentifier: Entity.CellType.reuseIdentifier
    )
  }

  override func bindViewModel() {
    super.bindViewModel()
    let viewWillLoad = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .map { [weak self] _ -> (Int, FilterType<Entity>) in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        return (0, self.selectedFilter.value)
      }
      .emptyDriverIfError()
    let collectionReachedNewPage = collectionView.rx.prefetchItems
      .compactMap { $0.last?.row }
      .map { $0 / 15 - 1 }
      .distinctUntilChanged({ $0 }, comparer: { $0 >= $1 })
      .skip(1)
      .map { [weak self] page -> (Int, FilterType<Entity>) in
        guard let self = self else { throw NetworkError.serviceUnloaded }
        print(page)
        return (page, self.selectedFilter.value)
      }
      .emptyDriverIfError()
    let filterChanged = self.selectedFilter.map { (0, $0) }.emptyDriverIfError()
    let input = EntityListViewModel<Entity>.Input(fetchEntities: Driver.merge([viewWillLoad, collectionReachedNewPage, filterChanged]))
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
