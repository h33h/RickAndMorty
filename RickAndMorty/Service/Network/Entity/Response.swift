//
//  Response.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct Response<T: EntityType>: Codable {
  let info: ResponseInfo
  let results: [T]
}
