//
//  ReusableView.swift
//  RickAndMorty
//
//  Created by XXX on 31.05.22.
//

import UIKit

protocol ReusableView {
  static var reuseIdentifier: String { get }
}

extension ReusableView {
  static var reuseIdentifier: String { String(describing: self) }
}

extension UICollectionViewCell: ReusableView {}
