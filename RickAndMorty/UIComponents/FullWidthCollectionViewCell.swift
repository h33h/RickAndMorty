//
//  FullWidthCollectionViewCell.swift
//  RickAndMorty
//
//  Created by XXX on 31.05.22.
//

import UIKit

class FullWidthCollectionViewCell: UICollectionViewCell {
  override func systemLayoutSizeFitting(
    _ targetSize: CGSize,
    withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
    verticalFittingPriority: UILayoutPriority
  ) -> CGSize {
    let size = super.systemLayoutSizeFitting(
      targetSize,
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    )
    return size
  }
}
