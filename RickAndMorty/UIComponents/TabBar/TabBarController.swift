//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by XXX on 26.05.22.
//

import SnapKit
import RxGesture
import RxSwift
import UIKit

class TabBarController: ViewController {
  private enum Constants {
    static var tabBar = UIDimension(
      idents: UIEdgeInsets(left: 15, right: 15, top: 10, bottom: 10),
      size: CGSize(height: 55))
    static var dividerLineWidth = 0.3
  }
  private(set) lazy var currentTabView = UIView()
  private(set) lazy var tabBar: UIStackView = {
    let stackView = UIStackView()
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.backgroundColor = .systemBackground
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = Constants.tabBar.idents
    return stackView
  }()
  private lazy var lineView: LineView = {
    let lineView = LineView()
    lineView.color = view.tintColor
    lineView.lineWidth = Constants.dividerLineWidth
    return lineView
  }()
  private(set) var tabs: [TabBarItemView: Presentable] = [:]
  private(set) var currentTab = PublishSubject<TabBarItemView>()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setupBinds()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupBinds()
  }

  func setTabs<T: TabBarItem>(_ tabs: [(tabBarItem: T, presentable: Presentable)]) {
    for (index, tab) in tabs.enumerated() {
      let itemView = TabBarItemView()
      itemView.setContent(tab.tabBarItem.content)
      self.tabs[itemView] = tab.presentable
      if index == .zero {
        currentTab.onNext(itemView)
      } else {
        itemView.switchState(with: TabBarItemNotSelectedState(tabBarItemView: itemView))
      }
      setTapGesture(to: itemView)
      tabBar.addArrangedSubview(itemView)
    }
  }

  private func setTapGesture(to tabView: TabBarItemView) {
    tabView
      .rx
      .tapGesture()
      .when(.recognized)
      .do(onNext: { [weak self] tap in
        guard
          let self = self,
          let tabTapped = tap.view as? TabBarItemView
        else { return }
        self.currentTab.onNext(tabTapped)
      })
      .emptyDriverIfError()
      .drive()
    .disposed(by: disposeBag)
  }

  private func switchCurrentTabViewController(with tab: TabBarItemView) {
    guard let viewController = tabs[tab]?.viewController else { return }
    currentTabView.subviews.forEach { $0.removeFromSuperview() }
    currentTabView.addSubview(viewController.view)
    viewController.view.snp.makeConstraints { make in
      make.edges.equalTo(currentTabView.snp.edges)
    }
  }

  private func setupBinds() {
    currentTab
      .do(onNext: { [weak self] currentTab in
        guard let self = self else { return }
        currentTab.switchState(with: TabBarItemSelectedState(tabBarItemView: currentTab))
        self.tabs.keys.forEach { tab in
          if tab !== currentTab {
            tab.switchState(with: TabBarItemNotSelectedState(tabBarItemView: tab))
          }
          self.switchCurrentTabViewController(with: currentTab)
        }
      })
      .emptyDriverIfError()
      .drive()
      .disposed(by: disposeBag)
  }

  override func setupUI() {
    super.setupUI()
    view.addSubview(currentTabView)
    view.addSubview(tabBar)
    view.addSubview(lineView)
    tabBar.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.height.equalTo(Constants.tabBar.size.height)
    }
    lineView.snp.makeConstraints { make in
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.bottom.equalTo(tabBar.snp.top)
      make.height.equalTo(Constants.dividerLineWidth)
    }
    currentTabView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.bottom.equalTo(tabBar.snp.top)
    }
  }
}
