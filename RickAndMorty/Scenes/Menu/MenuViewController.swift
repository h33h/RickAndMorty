//
//  MenuViewController.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import UIKit
import SnapKit

class MenuViewController: TabBarController, Storyboarded {
  private enum Constants {
    static var navigationBarView = UIDimension(
      idents: UIEdgeInsets(
        left: 15,
        right: 15,
        top: 0,
        bottom: 0),
      size: CGSize(height: 55))
    static var titleImage = UIImage(named: "textLogo")
    static var sortButtonImage = UIImage(systemName: "arrow.up.arrow.down.circle")
  }
  private(set) lazy var navigationBarView: UIStackView = {
    let navigationBarView = UIStackView()
    navigationBarView.distribution = .equalCentering
    navigationBarView.alignment = .fill
    navigationBarView.isLayoutMarginsRelativeArrangement = true
    navigationBarView.layoutMargins = Constants.navigationBarView.idents
    return navigationBarView
  }()
  private(set) lazy var indicatorBackgroundView = UIView()
  private(set) lazy var indicatorView: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView()
    indicatorBackgroundView.addSubview(indicatorView)
    indicatorView.hidesWhenStopped = true
    indicatorView.stopAnimating()
    return indicatorView
  }()
  private(set) lazy var titleImageView: UIImageView = {
    let titleImageView = UIImageView()
    titleImageView.image = Constants.titleImage
    titleImageView.contentMode = .scaleAspectFit
    return titleImageView
  }()
  private(set) lazy var sortButton: UIButton = {
    let sortButton = UIButton()
    sortButton.setImage(Constants.sortButtonImage, for: .normal)
    sortButton.contentMode = .scaleAspectFit
    sortButton.setPreferredSymbolConfiguration(.init(pointSize: 25), forImageIn: .normal)
    sortButton.tintColor = .appCyan
    sortButton.layer.shadowColor = UIColor.appGreen.cgColor
    sortButton.layer.shadowOffset = CGSize(width: 2, height: 2)
    return sortButton
  }()
  var viewModel: MenuViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func setupUI() {
    super.setupUI()
    view.addSubview(navigationBarView)
    navigationBarView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.equalTo(view.snp.left)
      make.right.equalTo(view.snp.right)
      make.height.equalTo(Constants.navigationBarView.size.height)
    }
    currentTabView.snp.makeConstraints { make in
      make.top.equalTo(navigationBarView.snp.bottom)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.bottom.equalTo(stackView.snp.top)
    }
    navigationBarView.addArrangedSubview(indicatorBackgroundView)
    navigationBarView.addArrangedSubview(titleImageView)
    navigationBarView.addArrangedSubview(sortButton)
    sortButton.snp.makeConstraints { make in
      make.width.equalTo(sortButton.snp.height)
    }
    indicatorBackgroundView.snp.makeConstraints { make in
      make.width.equalTo(indicatorBackgroundView.snp.height)
    }
    indicatorView.snp.makeConstraints { make in
      make.edges.equalTo(indicatorBackgroundView.snp.edges)
    }
  }
}
