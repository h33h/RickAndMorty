//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import Moya
import RxSwift

class RickAndMortyService {
  lazy var provider = MoyaProvider<RickAndMortyAPI>()

  func getCharacters(with settings: CharacterRequestSettings = CharacterRequestSettings()) -> Observable<ProgressResponse> {
    provider.rx.requestWithProgress(.getCharacters(params: settings))
  }

  func getLocations(with settings: LocationRequestSettings = LocationRequestSettings()) -> Observable<ProgressResponse> {
    provider.rx.requestWithProgress(.getLocations(params: settings))
  }

  func getEpisodes(with settings: EpisodeRequestSettings = EpisodeRequestSettings()) -> Observable<ProgressResponse> {
    provider.rx.requestWithProgress(.getEpisodes(params: settings))
  }
}
