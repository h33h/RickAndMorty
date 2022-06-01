//
//  UICollectionView+Extensions.swift
//  RickAndMorty
//
//  Created by XXX on 31.05.22.
//

import UIKit

extension UICollectionView {
  var widestCellWidth: CGFloat {
    let insets = contentInset.left + contentInset.right
    return bounds.width - insets
  }
}
