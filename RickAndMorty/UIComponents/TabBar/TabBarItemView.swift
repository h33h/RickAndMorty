//
//  TabBarItemView.swift
//  RickAndMorty
//
//  Created by XXX on 26.05.22.
//

import UIKit
import SnapKit

class TabBarItemView: UIView {
  private enum Constants {
    static let imageView = UIDimension(idents: UIEdgeInsets(left: 6))
    static let titleLabel = UIDimension(idents: UIEdgeInsets(left: 6, right: 6))
    static let titleFont = UIFont(name: "Avenir Next Medium", size: 18)
  }

  private(set) lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.font = Constants.titleFont
    return titleLabel
  }()
  private(set) lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  private(set) lazy var backgroundView: UIView = {
    let backgroundView = UIView()
    return backgroundView
  }()

  private(set) var state: TabBarItemState?
  private(set) var tabBarItemContent: TabBarItemContent?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundView.setRoundedCorners()
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

  func setContent(_ content: TabBarItemContent) {
    tabBarItemContent = content
  }

  func switchState(with state: TabBarItemState) {
    self.state = state
    state.updateUI()
  }
}
