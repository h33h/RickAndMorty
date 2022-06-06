//
//  TabBarItemView.swift
//  RickAndMorty
//
//  Created by XXX on 26.05.22.
//

import UIKit
import RxGesture
import RxSwift
import RxRelay
import SnapKit

private enum Constants {
  static let imageView = UIDimension(idents: UIEdgeInsets(left: 6))
  static let backgroundViewCornerRadius = 12.0
  static let titleLabel = UIDimension(idents: UIEdgeInsets(left: 6, right: 6))
  static let titleFont = UIFont(name: "Avenir Next Medium", size: 18)
}

class TabBarItemView: UIView {
  private(set) lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.font = Constants.titleFont
    titleLabel.textColor = .appCyan
    return titleLabel
  }()
  private(set) lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.tintColor = .appCyan
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  private(set) lazy var backgroundView: UIView = {
    let backgroundView = UIView()
    backgroundView.layer.cornerRadius = Constants.backgroundViewCornerRadius
    return backgroundView
  }()

  private let disposeBag = DisposeBag()
  let itemSelected = PublishRelay<TabBarItemView>()
  private var state: TabBarItemState? {
    didSet { state?.updateUI() }
  }
  private(set) var tabBarItemContent: TabBarItemContent

  init(tabBarItemContent: TabBarItemContent) {
    self.tabBarItemContent = tabBarItemContent
    super.init(frame: .zero)
    setupUI()
    addTapGesture()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    addSubview(backgroundView)
    backgroundView.snp.makeConstraints { make in
      make.edges.equalTo(snp.edges)
    }
    addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.width.equalTo(imageView.snp.height)
      make.centerY.equalTo(backgroundView.snp.centerY)
      make.left.equalTo(backgroundView.snp.left).offset(Constants.imageView.idents.left)
    }
    addSubview(titleLabel)
    titleLabel.snp.makeConstraints { make in
      make.left.equalTo(imageView.snp.right).offset(Constants.titleLabel.idents.left)
      make.right.equalTo(backgroundView.snp.right).inset(Constants.titleLabel.idents.right)
      make.centerY.equalTo(imageView.snp.centerY)
    }
  }

  func switchState(with state: TabBarItemState) {
    self.state = state
    state.updateUI()
  }
}

extension TabBarItemView {
  private func addTapGesture() {
    rx
    .tapGesture()
    .when(.recognized)
    .subscribe(
      onNext: { [weak self] _ in
        guard let self = self else { return }
        if self.state is TabBarItemNotSelectedState {
          self.itemSelected.accept(self)
        }
      }
    )
    .disposed(by: disposeBag)
  }
}
