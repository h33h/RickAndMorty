//
//  MenuViewModel.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import Foundation
import RxCocoa

class MenuViewModel: ViewModel {
  struct Input {
  }
  struct Output {}
  weak var coordinator: MenuCoordinator?
  func transform(input: Input) -> Output {
    Output()
  }

}
