//
//  Storyboarded.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation
import UIKit

protocol Storyboarded {
  static var storyboard: StoryboardID { get }
  static func instantiate() -> Self
}

extension Storyboarded {
  static func instantiate() -> Self {
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: id) as! Self
  }
}
