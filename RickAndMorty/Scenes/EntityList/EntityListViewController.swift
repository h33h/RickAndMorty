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

class EntityListViewController<T: EntityType>: UIViewController {
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    return collectionView
  }()
  private let disposeBag = DisposeBag()
  var viewModel: EntityListViewModel<T>?

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(UINib(nibName: T.CellType.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: T.CellType.reuseIdentifier)
    (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(
      width: collectionView.widestCellWidth,
      // Make the height a reasonable estimate to
      // ensure the scroll bar remains smooth
      height: 200
  )
    setupComponents()
    setupBindings()
  }

  private func setupComponents() {
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
  }

  private func setupBindings() {
    viewModel?.entities
      .bind(to: collectionView.rx.items(cellIdentifier: T.CellType.reuseIdentifier, cellType: T.CellType.self)) { row, data, cell in
      cell.configure(with: data as! T.CellType.Item)
      }
      .disposed(by: disposeBag)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: self.view.bounds.width, height: 300)
  }
}
