//
//  LocationCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit

class LocationCell: FullWidthCollectionViewCell {
  @IBOutlet var locationNameLabel: UILabel!
  @IBOutlet var locationTypeLabel: UILabel!
  @IBOutlet var locationDimensionLabel: UILabel!
}

extension LocationCell: CellConfigurable {
  typealias Item = Location
  func configure(with item: Location) -> Self {
    locationNameLabel.text = item.name
    locationTypeLabel.text = item.type
    locationDimensionLabel.text = item.dimension
    return self
  }
}
