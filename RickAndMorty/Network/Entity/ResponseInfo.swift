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
  let next: URL?
  let prev: URL?
}
