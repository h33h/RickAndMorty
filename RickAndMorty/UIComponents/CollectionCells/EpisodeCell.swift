//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit

class EpisodeCell: FullWidthCollectionViewCell {
  @IBOutlet var episodeNameLabel: UILabel!
  @IBOutlet var episodeLaunchDateLabel: UILabel!
  @IBOutlet var episodeCodeLabel: UILabel!
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
