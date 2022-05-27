//
//  Response.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct Response<T: Codable>: Codable {
  let info: ResponseInfo
  let results: [T]
}
