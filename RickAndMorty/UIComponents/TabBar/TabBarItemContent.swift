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

  init(title: String, image: UIImage, selectedImage: UIImage? = nil) {
    self.title = title
    self.image = image
    if let selectedImage = selectedImage {
      self.selectedImage = selectedImage
    } else {
      self.selectedImage = image
    }
  }
}
