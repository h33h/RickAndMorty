//
//  Observable+Extensions.swift
//  RickAndMorty
//
//  Created by XXX on 6.06.22.
//

import RxSwift
import RxCocoa

extension ObservableType {
  func emptyDriverIfError() -> Driver<Element> {
    return asDriver { _ in Driver<Element>.empty() }
  }
}
