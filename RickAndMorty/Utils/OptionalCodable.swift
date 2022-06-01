//
//  OptionalCodable.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import Foundation

@propertyWrapper
struct OptionalCodable<Wrapped: Codable>: Codable {
  var wrappedValue: Wrapped?

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    wrappedValue = try? container.decode(Wrapped.self)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(wrappedValue)
  }
}
