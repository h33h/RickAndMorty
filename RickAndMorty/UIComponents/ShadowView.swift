//
//  ShadowView.swift
//  RickAndMorty
//
//  Created by XXX on 31.05.22.
//

import UIKit

class ShadowView: UIView {

  override func layoutSubviews() {
    super.layoutSubviews()
    setupShadow()
  }

  private func setupShadow() {
    layer.cornerRadius = 8
    layer.shadowOffset = CGSize(width: 0, height: 3)
    layer.shadowRadius = 3
    layer.shadowOpacity = 0.3
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 13).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
}
