//
//  ShadowView.swift
//  RickAndMorty
//
//  Created by XXX on 31.05.22.
//

import UIKit

private enum Constants {
  static var cornerRadius = 8.0
  static var shadowOffset = CGSize(width: 0, height: 3)
  static var shadowRadius = 3.0
  static var shadowOpacity = 0.3
  static var shadowPathCornerRadius = 13.0
}

class ShadowView: UIView {
  override func layoutSubviews() {
    super.layoutSubviews()
    setupShadow()
  }

  private func setupShadow() {
    layer.cornerRadius = Constants.cornerRadius
    layer.shadowOffset = Constants.shadowOffset
    layer.shadowRadius = Constants.shadowRadius
    layer.shadowOpacity = Float(Constants.shadowOpacity)
    layer.shadowPath = UIBezierPath(
      roundedRect: bounds,
      cornerRadius: Constants.shadowPathCornerRadius).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
}
