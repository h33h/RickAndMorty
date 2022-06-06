//
//  CellConfigurable.swift
//  RickAndMorty
//
//  Created by XXX on 31.05.22.
//

import UIKit

protocol CellConfigurable: UICollectionViewCell {
  associatedtype Item: EntityType
  @discardableResult
  func configure(with item: Item) -> Self
}
