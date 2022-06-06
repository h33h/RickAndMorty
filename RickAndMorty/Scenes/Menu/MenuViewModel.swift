//
//  MenuViewModel.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation

class MenuViewModel: ViewModel {
  struct Input {}
  struct Output {}
  weak var coordinator: MenuCoordinator?
  func transorm(input: Input) -> Output {
    Output()
  }

}
