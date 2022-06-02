//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit
import RxSwift

class CharacterCell: FullWidthCollectionViewCell {
  @IBOutlet weak var characterImageView: UIImageView!
  @IBOutlet weak var characterNameLabel: UILabel!
  @IBOutlet weak var characterSpeciesLabel: UILabel!
  @IBOutlet weak var characterLifeStatus: LifeStatusIndicator!
  private var previousImageUrl: URL?
  private var imageService: ImageProvider?
  private let disposeBag = DisposeBag()

  private func updateImage(with url: URL?) {
    guard let url = url else { return }
    previousImageUrl = url
    imageService?.getImage(with: url)
      .subscribe(
        onSuccess: { [weak self] image in
          guard
            let self = self,
            let previousImageUrl = self.previousImageUrl,
            previousImageUrl == url
          else { return }
          self.characterImageView.image = image
        }
      )
      .disposed(by: disposeBag)
  }
}

extension CharacterCell: CellConfigurable {
  typealias Item = Character
  func configure(with item: Character) -> Self {
    characterNameLabel.text = item.name
    characterSpeciesLabel.text = item.species
    characterLifeStatus.isAlive = item.status
    updateImage(with: item.image)
    return self
  }
}
