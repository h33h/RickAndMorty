//
//  EntityListViewController.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private enum Constants {
  static var collectionView = UIDimension(idents: UIEdgeInsets(left: 10, right: 10, top: 10, bottom: 10))
  static var cellHeightMultiplier = 0.5
  static var itemsCountPassedBeforePrefetch = 15
  static var pageOffset = 1
  static var firstPage = 1
}

class EntityListViewController<T: EntityType>: ViewController {
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.contentInset = Constants.collectionView.idents
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()
  var viewModel: EntityListViewModel<T>?

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(
      UINib(nibName: T.CellType.reuseIdentifier, bundle: nil),
      forCellWithReuseIdentifier: T.CellType.reuseIdentifier)
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.itemSize = CGSize(
        width: collectionView.widestCellWidth,
        height: collectionView.widestCellWidth * Constants.cellHeightMultiplier)
    }
    setupComponents()
    setupBindings()
    viewModel?.getEntities()
  }

  private func setupComponents() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
  }

  private func setupBindings() {
    viewModel?.entities
      .asDriver()
      .drive(collectionView.rx.items) { collectionView, row, item in
        let indexPath = IndexPath(row: row, section: .zero)
        let cell: T.CellType = DIContainer.shared.resolve(arguments: collectionView, indexPath)
        if let item = item as? T.CellType.Item {
          cell.configure(with: item)
        }
        return cell
      }
      .disposed(by: disposeBag)
    collectionView
      .rx
      .prefetchItems
      .compactMap { $0.last?.row }
      .map { $0 / Constants.itemsCountPassedBeforePrefetch }
      .map { $0 + Constants.pageOffset }
      .distinctUntilChanged({ $0 }, comparer: { $0 >= $1 })
      .skip(Constants.firstPage)
      .subscribe(onNext: { [weak self] page in
        print(page)
        if
          let self = self,
          var settings = self.viewModel?.requestSettings {
          settings.page = page
          self.viewModel?.updateRequestSettings(with: settings)
          self.viewModel?.getEntities()
        }
      })
      .disposed(by: disposeBag)
  }
}
