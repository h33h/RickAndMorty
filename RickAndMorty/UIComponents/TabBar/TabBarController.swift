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

class TabBarController<T: TabBarItem>: UIViewController {
  lazy var currentTabView: UIView = { UIView() }()
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    return stackView
  }()
  private(set) var currentIndex = 0
  private(set) var tabs: [TabBarItemView] = []
  private(set) var viewControllers: [UIViewController] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    setupComponents()
  }

  func setViewControllers(_ viewControllers: [UIViewController]) {
    self.viewControllers = viewControllers
    switchCurrentTabView(with: viewControllers[currentIndex])
  }

  private func switchCurrentTabView(with viewController: UIViewController) {
    currentTabView.subviews.forEach { $0.removeFromSuperview() }
    currentTabView.addSubview(viewController.view)
    viewController.view.snp.makeConstraints { make in
      make.edges.equalTo(currentTabView.snp.edges)
    }
  }

  private func setupComponents() {
    view.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
      make.height.equalTo(70)
    }
    view.addSubview(currentTabView)
    currentTabView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      make.bottom.equalTo(stackView.snp.top)
    }
    setupTabs()
  }
  private func setupTabs() {
    for (index, tab) in T.allCases.enumerated() {
      let tabView = TabBarItemView.instantiate(with: tab.content)
      if index == 0 { tabView.switchState(with: TabBarItemSelectedState(tabBarItemView: tabView)) }
      tabView.delegate = self
      tabs.append(tabView)
      self.stackView.addArrangedSubview(tabView)
    }
  }
}

extension TabBarController: TabBarItemViewDelegate {
  func didSelect(_ tabBarItemView: TabBarItemView) {
    tabs[currentIndex].switchState(with: TabBarItemNotSelectedState(to: tabs[currentIndex]))
    currentIndex = tabs.firstIndex { $0 === tabBarItemView } ?? 0
    switchCurrentTabView(with: viewControllers[currentIndex])
  }
}
