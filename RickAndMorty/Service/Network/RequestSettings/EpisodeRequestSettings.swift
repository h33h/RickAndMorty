//
//  EpisodeRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

struct EpisodeRequestSettings: RequestSettings {
  let basePath = "/episode"

  var parameters: [String: Any] {
    var requestParams: [String: Any] = [:]
    requestParams["name"] = name
    requestParams["episode"] = episode
    requestParams["page"] = page
    return requestParams
  }

  var ids: [Int] = []
  var page: Int = 1
  var name: String? = nil
  var episode: String? = nil
}
