//
//  UIView+Extensions.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

import UIKit

extension UIView {
  func setRoundedCorners(ratio: Double = 0.188) {
    layer.cornerRadius = ratio * min(frame.width, frame.height)
    layer.masksToBounds = true
  }
}
