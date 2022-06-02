//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit

class EpisodeCell: FullWidthCollectionViewCell {
  @IBOutlet weak var episodeNameLabel: UILabel!
  @IBOutlet weak var episodeLaunchDateLabel: UILabel!
  @IBOutlet weak var episodeCodeLabel: UILabel!
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
