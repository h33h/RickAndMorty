//
//  Storyboarded.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation
import UIKit

protocol Storyboarded {
  static var storyboardName: StoryboardName { get }
  static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
  static func instantiate() -> Self {
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
    guard let viewController = storyboard.instantiateViewController(withIdentifier: id) as? Self else {
      fatalError("ViewController not found")
    }
    return viewController
  }
}
