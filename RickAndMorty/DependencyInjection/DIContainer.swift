//
//  DIContainer.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Swinject

class DIContainer {
  static let shared = DIContainer()
  let container = Container()
  lazy var assembler: Assembler = { Assembler(container: container) }()

  private init() {}

  func resolve<T>() -> T {
    guard let resolvedType = container.resolve(T.self) else { fatalError("Not found resolvedType") }
    return resolvedType
  }

  func resolve<T>(registrationName: String?) -> T {
    guard let resolvedType = container.resolve(T.self, name: registrationName) else {
      fatalError("Not found resolvedType")
    }
    return resolvedType
  }

  func resolve<T, Arg>(argument: Arg) -> T {
    guard let resolvedType = container.resolve(T.self, argument: argument) else { fatalError("Not found resolvedType") }
    return resolvedType
  }

  func resolve<T, Arg1, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> T {
    guard let resolvedType = container.resolve(T.self, arguments: arg1, arg2) else {
      fatalError("Not found resolvedType")
    }
    return resolvedType
  }

  func resolve<T, Arg>(name: String?, argument: Arg) -> T {
    guard let resolvedType = container.resolve(T.self, name: name, argument: argument) else {
      fatalError("Not found resolvedType")
    }
    return resolvedType
  }

  func resolve<T, Arg1, Arg2>(name: String?, arguments arg1: Arg1, _ arg2: Arg2) -> T {
    guard let resolvedType = container.resolve(T.self, name: name, arguments: arg1, arg2) else {
      fatalError("Not found resolvedType")
    }
    return resolvedType
  }

  func resolve<T, Arg1, Arg2, Arg3>(arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> T {
    guard let resolvedType = container.resolve(T.self, arguments: arg1, arg2, arg3) else {
      fatalError("Not found resolvedType")
    }
    return resolvedType
  }
}
