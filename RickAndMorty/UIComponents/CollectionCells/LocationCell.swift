//
//  LocationCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit

class LocationCell: FullWidthCollectionViewCell {
  @IBOutlet private(set) weak var locationNameLabel: UILabel!
  @IBOutlet private(set) weak var locationTypeLabel: UILabel!
  @IBOutlet private(set) weak var locationDimensionLabel: UILabel!
}

extension LocationCell: CellConfigurable {
  typealias Item = Location
  func configure(with item: Location) {
    locationNameLabel.text = item.name
    locationTypeLabel.text = item.type
    locationDimensionLabel.text = item.dimension
  }
}
