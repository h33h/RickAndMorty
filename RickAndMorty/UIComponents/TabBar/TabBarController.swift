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
  static var stackView = UIDimension(idents: UIIdents(left: 20, right: 20), size: CGSize(height: 70))
}

class TabBarController<T: TabBarItem>: UIViewController {
  private(set) lazy var currentTabView = UIView()
  private(set) lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    return stackView
  }()
  private(set) var currentIndex: Int = .zero
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
      make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(Constants.stackView.idents.left)
      make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(Constants.stackView.idents.right)
      make.height.equalTo(Constants.stackView.size.height)
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
      if index == .zero { tabView.switchState(with: TabBarItemSelectedState(tabBarItemView: tabView)) }
      tabView.delegate = self
      tabs.append(tabView)
      self.stackView.addArrangedSubview(tabView)
    }
  }
}

extension TabBarController: TabBarItemViewDelegate {
  func didSelect(_ tabBarItemView: TabBarItemView) {
    tabs[currentIndex].switchState(with: TabBarItemNotSelectedState(to: tabs[currentIndex]))
    currentIndex = tabs.firstIndex { $0 === tabBarItemView } ?? .zero
    if currentIndex < viewControllers.count {
      switchCurrentTabView(with: viewControllers[currentIndex])
    } else {
      fatalError("There is no viewController for this tab, setup viewControllers for all tabs")
    }
  }
}
