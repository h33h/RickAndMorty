//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit

class EpisodeCell: FullWidthCollectionViewCell {
  @IBOutlet private(set) weak var episodeNameLabel: UILabel!
  @IBOutlet private(set) weak var episodeLaunchDateLabel: UILabel!
  @IBOutlet private(set) weak var episodeCodeLabel: UILabel!
}

extension EpisodeCell: CellConfigurable {
  typealias Item = Episode
  func configure(with item: Episode) -> Self {
    episodeNameLabel.text = item.name
    episodeLaunchDateLabel.text = item.airDate
    episodeCodeLabel.text = item.episode
    return self
  }
}
