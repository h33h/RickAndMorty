//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit

class CharacterCell: UICollectionViewCell {
  @IBOutlet var characterImageView: UIImageView!
  @IBOutlet var characterNameLabel: UILabel!
  @IBOutlet var characterSpeciesLabel: UILabel!
  @IBOutlet var characterLifeStatus: LifeStatusIndicator!
}
