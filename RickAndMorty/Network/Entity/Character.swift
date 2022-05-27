//
//  Character.swift
//  RickAndMorty
//
//  Created by XXX on 27.05.22.
//

import Foundation

struct Character: Codable {
  let id: Int
  let name: String
  let status: String
  let species: String
  let type: String
  let gender: String
  let origin: CharacterLocation
  let location: CharacterLocation
  let image: URL
  let episode: [URL]
  let url: URL
  let created: Date
}

struct CharacterLocation: Codable {
  let name: String
  let url: URL
}
