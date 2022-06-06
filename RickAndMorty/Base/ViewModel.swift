//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by XXX on 5.06.22.
//

protocol ViewModel {
  associatedtype Input
  associatedtype Output
  associatedtype CoordinatorType: Coordinator

  var coordinator: CoordinatorType? { get set }

  func transorm(input: Input) -> Output
}
