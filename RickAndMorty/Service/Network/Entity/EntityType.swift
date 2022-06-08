//
//  EntityType.swift
//  RickAndMorty
//
//  Created by XXX on 30.05.22.
//

import ObjectMapper

protocol EntityType: Mappable {
  associatedtype CellType: CellConfigurable
  associatedtype RequestType: RequestSettings
  associatedtype ParameterType: RequestParameter
}
