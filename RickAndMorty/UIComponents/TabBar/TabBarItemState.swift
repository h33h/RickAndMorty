//
//  TabBarItemState.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import UIKit

protocol TabBarItemState {
  func updateUI()
}

class TabBarItemSelectedState: TabBarItemState {
  private weak var tabBarItemView: TabBarItemView?

  init(tabBarItemView: TabBarItemView?) {
    self.tabBarItemView = tabBarItemView
  }

  func updateUI() {
    guard let content = tabBarItemView?.content else { return }
    UIView.animate(
      withDuration: 0.4,
      delay: 0.0,
      usingSpringWithDamping: 1.0,
      initialSpringVelocity: 0.5,
      options: .curveEaseIn,
      animations: { [weak self] in
        self?.tabBarItemView?.titleLabel.text = content.title
        self?.tabBarItemView?.imageView.image = UIImage(systemName: content.selectedImageName)
        self?.tabBarItemView?.backgroundView.backgroundColor = UIColor.appGreen
        self?.tabBarItemView?.superview?.layoutIfNeeded()
      }, completion: nil)
  }
}

class TabBarItemNotSelectedState: TabBarItemState {
  private weak var tabBarItemView: TabBarItemView?

  init(to tabBarItemView: TabBarItemView?) {
    self.tabBarItemView = tabBarItemView
  }

  func updateUI() {
    guard let content = tabBarItemView?.content else { return }
    UIView.animate(
      withDuration: 0.4,
      delay: 0.0,
      usingSpringWithDamping: 1.0,
      initialSpringVelocity: 0.5,
      options: .curveEaseOut,
      animations: { [weak self] in
        self?.tabBarItemView?.titleLabel.text = ""
        self?.tabBarItemView?.imageView.image = UIImage(systemName: content.imageName)
        self?.tabBarItemView?.backgroundView.backgroundColor = .clear
        self?.tabBarItemView?.superview?.layoutIfNeeded()
      }, completion: nil)
  }
}
