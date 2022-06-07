//
//  TabBarItemContent.swift
//  RickAndMorty
//
//  Created by XXX on 26.05.22.
//

import UIKit

struct TabBarItemContent {
  var title: String
  var image: UIImage
  var selectedImage: UIImage
  var tintColor: UIColor
  var backgroundColor: UIColor

  init(title: String, image: UIImage, selectedImage: UIImage? = nil, tintColor: UIColor = .black, backgroundColor: UIColor = .systemBackground) {
    self.title = title
    self.image = image
    if let selectedImage = selectedImage { self.selectedImage = selectedImage }
    else { self.selectedImage = image }
    self.tintColor = tintColor
    self.backgroundColor = backgroundColor
  }
}
