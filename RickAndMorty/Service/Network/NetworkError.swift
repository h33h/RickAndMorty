//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by XXX on 5.06.22.
//

import Foundation

enum NetworkError: Error {
  case serviceUnloaded
}

extension NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .serviceUnloaded: return "An instance of the service class has been unloaded"
    }
  }
}
