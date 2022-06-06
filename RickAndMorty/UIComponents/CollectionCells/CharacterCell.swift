//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit
import RxSwift

class CharacterCell: FullWidthCollectionViewCell {
  @IBOutlet private(set) weak var characterImageView: UIImageView!
  @IBOutlet private(set) weak var characterNameLabel: UILabel!
  @IBOutlet private(set) weak var characterSpeciesLabel: UILabel!
  @IBOutlet private(set) weak var characterLifeStatus: LifeStatusIndicator!
  @IBOutlet private(set) weak var imageActivityIndicator: UIActivityIndicatorView!
  @IBOutlet private(set) weak var imageLoadingErrorView: UIView!
  @IBOutlet private(set) weak var imageLoadingErrorDescription: UILabel!

  private var currentImageRequest: Disposable?
  private let disposeBag = DisposeBag()
  var imageService: ImageProvider?

  private func updateImage(with url: URL?) {
    guard let url = url else { return }
    imageActivityIndicator.startAnimating()
    currentImageRequest = imageService?.getImage(with: url)
      .observe(on: MainScheduler.instance)
      .subscribe(
        onSuccess: { [weak self] image in
          guard let self = self else { return }
          self.imageActivityIndicator.stopAnimating()
          self.characterImageView.image = image
        },
        onFailure: { [weak self] error in
          guard let self = self else { return }
          self.imageActivityIndicator.stopAnimating()
          self.imageLoadingErrorDescription.text = error.localizedDescription
          self.imageLoadingErrorView.isHidden = false
        }
      )
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    currentImageRequest?.dispose()
    imageActivityIndicator.stopAnimating()
    imageLoadingErrorView.isHidden = true
    characterImageView.image = nil
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
