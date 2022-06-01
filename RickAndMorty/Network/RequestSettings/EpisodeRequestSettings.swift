//
//  EpisodeRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct EpisodeRequestSettings: RequestSettings {
  var basePath: String = "/episode"

  var parameters: [String : Any] {
    var requestParams: [String: Any] = [:]
    requestParams["name"] = name
    requestParams["episode"] = episode
    requestParams["page"] = page
    return requestParams
  }

  let ids: [Int]? = nil
  let page: Int? = nil
  let name: String? = nil
  let episode: String? = nil
}
