//
//  CGSize+Extensions.swift
//  RickAndMorty
//
//  Created by XXX on 2.06.22.
//

import UIKit

extension CGSize {
  init(width: Double = 0, height: Double = 0) {
    self.init(width: CGFloat(width), height: CGFloat(height))
  }
}
