//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by XXX on 26.05.22.
//

import SnapKit
import UIKit

protocol TabBarItem: CaseIterable {
  var content: TabBarItemContent { get }
}

private enum Constants {
  static var stackView = UIDimension(
    idents: UIEdgeInsets(
      left: 15,
      right: 15,
      top: 10,
      bottom: 10),
    size: CGSize(height: 55))
  static var dividerLineWidth = 1.0
}

class TabBarController: ViewController {
  private(set) lazy var currentTabView = UIView()
  private(set) lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.backgroundColor = .systemBackground
    stackView.isLayoutMarginsRelativeArrangement = true
    stackView.layoutMargins = Constants.stackView.idents
    return stackView
  }()
  private(set) lazy var lineView: LineView = {
    let lineView = LineView()
    lineView.color = .black
    lineView.lineWidth = Constants.dividerLineWidth
    return lineView
  }()
  private(set) var tabs: [TabBarItemView: ViewController] = [:]
  private(set) var currentTab: TabBarItemView?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func setTabs<T: TabBarItem>(tabBarItemType: T.Type, with viewControllers: [ViewController]) {
    if T.allCases.count == viewControllers.count {
      for (index, tab) in T.allCases.enumerated() {
        let itemView = TabBarItemView(tabBarItemContent: tab.content)
        self.tabs[itemView] = viewControllers[index]
        itemView.switchState(with: TabBarItemNotSelectedState(tabBarItemView: itemView))
        if index == .zero {
          switchCurrentTab(with: itemView)
        }
        itemView.itemSelected.subscribe(onNext: { [weak self] item in
          guard let self = self else { return }
          self.switchCurrentTab(with: item)
        })
        .disposed(by: disposeBag)
        stackView.addArrangedSubview(itemView)
      }
    }
  }

  private func switchCurrentTab(with tab: TabBarItemView) {
    currentTab?.switchState(with: TabBarItemNotSelectedState(tabBarItemView: currentTab))
    currentTab = tab
    tab.switchState(with: TabBarItemSelectedState(tabBarItemView: tab))
    guard let viewController = tabs[tab] else { return }
    currentTabView.subviews.forEach { $0.removeFromSuperview() }
    currentTabView.addSubview(viewController.view)
    viewController.view.snp.makeConstraints { make in
      make.edges.equalTo(currentTabView.snp.edges)
    }
  }

  override func setupUI() {
    super.setupUI()
    view.addSubview(currentTabView)
    view.addSubview(stackView)
    view.addSubview(lineView)
    stackView.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.height.equalTo(Constants.stackView.size.height)
    }
    lineView.snp.makeConstraints { make in
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.bottom.equalTo(stackView.snp.top)
      make.height.equalTo(Constants.dividerLineWidth)
    }
  }
}
