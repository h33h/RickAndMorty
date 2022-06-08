//
//  Single+Extensions.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

import RxSwift
import ObjectMapper

extension PrimitiveSequence where Trait == SingleTrait {
  func mapObject<T: Mappable>(type: T.Type) -> Single<T> {
    self.map { response in
      guard let dict = response as? [String: Any],
            let mapped = Mapper<T>().map(JSON: dict)
      else { throw RxSwiftMoyaError.parseJSONError }
      return mapped
    }
  }

  func mapArray<T: Mappable>(type: T.Type) -> Single<[T]> {
    return self.map { response in
      guard let array = response as? [[String: Any]] else {
        throw RxSwiftMoyaError.parseJSONError
      }
      return Mapper<T>().mapArray(JSONArray: array)
    }
  }
}

enum RxSwiftMoyaError: String, Error {
  case parseJSONError
  case otherError
}
