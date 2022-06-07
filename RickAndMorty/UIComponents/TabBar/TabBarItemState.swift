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

private enum Constants {
  static var animationDuration = 0.4
  static var animationDelay = 0.0
  static var animationSpringDamping = 1.0
  static var animationSpringVelocity = 0.5
}

class TabBarItemSelectedState: TabBarItemState {
  private weak var tabBarItemView: TabBarItemView?

  init(tabBarItemView: TabBarItemView?) {
    self.tabBarItemView = tabBarItemView
  }

  func updateUI() {
    UIView.animate(
      withDuration: Constants.animationDuration,
      delay: Constants.animationDelay,
      usingSpringWithDamping: Constants.animationSpringDamping,
      initialSpringVelocity: Constants.animationSpringVelocity,
      options: .curveEaseIn,
      animations: { [weak self] in
        guard let self = self, let content = self.tabBarItemView?.tabBarItemContent else { return }
        self.tabBarItemView?.titleLabel.text = content.title
        self.tabBarItemView?.titleLabel.textColor = content.tintColor
        self.tabBarItemView?.imageView.image = content.selectedImage
        self.tabBarItemView?.imageView.tintColor = content.tintColor
        self.tabBarItemView?.backgroundView.backgroundColor = content.backgroundColor
        self.tabBarItemView?.superview?.layoutIfNeeded()
      }, completion: nil)
  }
}

class TabBarItemNotSelectedState: TabBarItemState {
  private weak var tabBarItemView: TabBarItemView?

  init(tabBarItemView: TabBarItemView?) {
    self.tabBarItemView = tabBarItemView
  }

  func updateUI() {
    UIView.animate(
      withDuration: Constants.animationDuration,
      delay: Constants.animationDelay,
      usingSpringWithDamping: Constants.animationSpringDamping,
      initialSpringVelocity: Constants.animationSpringVelocity,
      options: .curveEaseOut,
      animations: { [weak self] in
        guard let self = self, let content = self.tabBarItemView?.tabBarItemContent else { return }
        self.tabBarItemView?.titleLabel.text = String()
        self.tabBarItemView?.titleLabel.textColor = content.tintColor
        self.tabBarItemView?.imageView.image = content.image
        self.tabBarItemView?.imageView.tintColor = content.tintColor
        self.tabBarItemView?.backgroundView.backgroundColor = .clear
        self.tabBarItemView?.superview?.layoutIfNeeded()
      }, completion: nil)
  }
}
