//
//  NavigationController.swift
//  RickAndMorty
//
//  Created by XXX on 6.06.22.
//

import UIKit

class NavigationController: UINavigationController {
  private enum Constants {
    static var backButtonImage = UIImage(systemName: "chevron.backward")
    static var titleFont = UIFont(name: "Avenir Next Bold", size: 32)
    static var titleShadowOffset = CGSize(width: 2, height: 2)
    static var titleMinimumScaleFactor = 0.5
    static var indicatorView = UIDimension(idents: UIEdgeInsets(right: 5))
    static var backButton = UIDimension(idents: UIEdgeInsets(left: 10))
    static var rightAction = UIDimension(idents: UIEdgeInsets(right: 10))
    static var dividerLineWidth = 0.3
  }

  private lazy var navigationBarView = UIView()

  private lazy var lineView: LineView = {
    let lineView = LineView()
    lineView.color = .appCyan
    lineView.lineWidth = Constants.dividerLineWidth
    return lineView
  }()

  private lazy var titleTextView: UILabel = {
    let titleTextView = UILabel()
    titleTextView.font = Constants.titleFont
    titleTextView.textColor = .appCyan
    titleTextView.shadowColor = .appGreen
    titleTextView.shadowOffset = Constants.titleShadowOffset
    titleTextView.textAlignment = .center
    titleTextView.minimumScaleFactor = Constants.titleMinimumScaleFactor
    titleTextView.adjustsFontSizeToFitWidth = true
    return titleTextView
  }()

  private(set) lazy var indicatorView: UIActivityIndicatorView = {
    let indicatorView = UIActivityIndicatorView()
    indicatorView.hidesWhenStopped = true
    indicatorView.stopAnimating()
    return indicatorView
  }()

  private(set) lazy var backButton: UIButton = {
    let backButton = UIButton()
    backButton.setImage(Constants.backButtonImage, for: .normal)
    backButton.setTitleColor(.appCyan, for: .normal)
    backButton.isHidden = true
    return backButton
  }()

  private lazy var rightActionButtonPlace = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func addActionButton(_ button: UIButton) {
    rightActionButtonPlace.subviews.forEach { $0.removeFromSuperview() }
    rightActionButtonPlace.addSubview(button)
    button.snp.makeConstraints { make in
      make.edges.equalTo(rightActionButtonPlace.snp.edges)
    }
  }

  func setTitle(_ title: String) {
    titleTextView.text = title
  }

  private func setupUI() {
    navigationBar.addSubview(navigationBarView)
    navigationBarView.snp.makeConstraints { make in
      make.top.equalTo(navigationBar.snp.top)
      make.left.equalTo(navigationBar.snp.left)
      make.right.equalTo(navigationBar.snp.right)
      make.height.equalTo(navigationBar.snp.height)
    }
    navigationBarView.addSubview(lineView)
    lineView.snp.makeConstraints { make in
      make.left.equalTo(navigationBar.snp.left)
      make.right.equalTo(navigationBar.snp.right)
      make.top.equalTo(navigationBar.snp.bottom)
      make.height.equalTo(Constants.dividerLineWidth)
    }
    navigationBarView.addSubview(titleTextView)
    titleTextView.snp.makeConstraints { make in
      make.center.equalTo(navigationBarView.snp.center)
    }
    navigationBarView.addSubview(indicatorView)
    indicatorView.snp.makeConstraints { make in
      make.centerY.equalTo(navigationBarView.snp.centerY)
      make.right.equalTo(titleTextView.snp.left).offset(Constants.indicatorView.idents.right)
    }
    navigationBarView.addSubview(backButton)
    backButton.snp.makeConstraints { make in
      make.centerY.equalTo(navigationBarView.snp.centerY)
      make.left.equalTo(navigationBarView.snp.left).offset(Constants.backButton.idents.left)
      make.right.lessThanOrEqualTo(indicatorView.snp.left)
    }
    navigationBarView.addSubview(rightActionButtonPlace)
    rightActionButtonPlace.snp.makeConstraints { make in
      make.centerY.equalTo(navigationBarView.snp.centerY)
      make.right.equalTo(navigationBarView.snp.right).inset(Constants.rightAction.idents.right)
      make.width.equalTo(rightActionButtonPlace.snp.height)
    }
  }
}
