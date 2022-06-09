//
//  EntityRequestSettings.swift
//  RickAndMorty
//
//  Created by XXX on 9.06.22.
//

class EntityRequestSettings<Entity: EntityType>: RequestSettings {
  var parameters: [Entity.ParameterType]
  var endpoint: Entity.EndPointType
  var page: Int
  
  required init() {
    self.endpoint = Entity.EndPointType()
    self.parameters = []
    self.page = 0
  }
}
