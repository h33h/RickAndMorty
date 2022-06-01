//
//  String+Extensions.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import Foundation

extension StringProtocol {
  var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
  var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
