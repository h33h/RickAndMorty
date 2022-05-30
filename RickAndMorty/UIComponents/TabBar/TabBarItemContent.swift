//
//  TabBarItemContent.swift
//  RickAndMorty
//
//  Created by XXX on 26.05.22.
//

import Foundation

class TabBarItemContent {
  var title: String
  var imageName: String
  var selectedImageName: String

  init(title: String, imageName: String, selectedImageName: String? = nil) {
    self.title = title
    self.imageName = imageName
    if let selectedImageName = selectedImageName {
      self.selectedImageName = selectedImageName
    } else {
      self.selectedImageName = imageName
    }
  }
}
