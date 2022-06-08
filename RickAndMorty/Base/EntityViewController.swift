//
//  ListViewController.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import UIKit
import SnapKit

private enum Constants {
  static var collectionView = UIDimension(idents: UIEdgeInsets(left: 10, right: 10, top: 10, bottom: 10))
  static var cellHeightMultiplier = 0.5
}

class ListViewController: ViewController {
  private(set) lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.contentInset = Constants.collectionView.idents
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()

  private func setupCollectionViewLayout() {
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.itemSize = CGSize(
        width: collectionView.widestCellWidth,
        height: collectionView.widestCellWidth * Constants.cellHeightMultiplier)
    }
  }

  override func setupUI() {
    super.setupUI()
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
    setupCollectionViewLayout()
  }

//  override func bindViewModel() {
//    super.bindViewModel()
//    let viewWillAppear = rx
//      .sentMessage(#selector(UIViewController.viewWillAppear(_:)))
//      .map { _ in return }
//      .emptyDriverIfError()
//    let fetchTask = fetchTask.asObserver().emptyDriverIfError()
//    let input = EntityListViewModel<T>.Input(loadTrigger: viewWillAppear, fetchTrigger: fetchTask)
//    let output = viewModel.transform(input: input)
//    output.entities
//      .drive(collectionView.rx.items) { collectionView, row, item in
//        let indexPath = IndexPath(row: row, section: .zero)
//        let cell: T.CellType = DIContainer.shared.resolve(arguments: collectionView, indexPath)
//        cell.configure(with: item)
//        return cell
//      }
//      .disposed(by: disposeBag)
//    output.isLoading.drive(isLoading).disposed(by: disposeBag)
//  }
//
//  private func setupBindings() {
//    viewModel?.entities
//      .asDriver()
//      .drive(collectionView.rx.items) { collectionView, row, item in
//        let indexPath = IndexPath(row: row, section: .zero)
//        let cell: T.CellType = DIContainer.shared.resolve(arguments: collectionView, indexPath)
//        if let item = item as? T.CellType.Item {
//          cell.configure(with: item)
//        }
//        return cell
//      }
//      .disposed(by: disposeBag)
//    collectionView
//      .rx
//      .prefetchItems
//      .compactMap { $0.last?.row }
//      .map { $0 / Constants.itemsCountPassedBeforePrefetch }
//      .map { $0 + Constants.pageOffset }
//      .distinctUntilChanged({ $0 }, comparer: { $0 >= $1 })
//      .skip(Constants.firstPage)
//      .subscribe(onNext: { [weak self] page in
//        print(page)
//        if
//          let self = self,
//          var settings = self.viewModel?.requestSettings {
//          settings.page = page
//          self.viewModel?.updateRequestSettings(with: settings)
//          self.viewModel?.getEntities()
//        }
//      })
//      .disposed(by: disposeBag)
//  }
}
