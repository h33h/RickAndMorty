//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit

class CharacterCell: FullWidthCollectionViewCell {
  @IBOutlet var characterImageView: UIImageView!
  @IBOutlet var characterNameLabel: UILabel!
  @IBOutlet var characterSpeciesLabel: UILabel!
  @IBOutlet var characterLifeStatus: LifeStatusIndicator!
}

extension CharacterCell: CellConfigurable {
  typealias Item = Character
  func configure(with item: Character) -> Self {
    characterNameLabel.text = item.name
    characterSpeciesLabel.text = item.species
    characterLifeStatus.isAlive = item.status
    characterImageView.image = UIImage(data: try! Data(contentsOf: item.image!), scale: 1.0)
    return self
  }
}
