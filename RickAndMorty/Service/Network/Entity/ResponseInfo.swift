//
//  ResponseInfo.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct ResponseInfo: Codable {
  let count: Int
  let pages: Int
  @OptionalCodable var next: URL?
  @OptionalCodable var prev: URL?
}
