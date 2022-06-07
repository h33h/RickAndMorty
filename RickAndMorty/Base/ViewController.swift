//
//  ViewController.swift
//  RickAndMorty
//
//  Created by XXX on 5.06.22.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
  let disposeBag = DisposeBag()

  var navi: NavigationController? {
    navigationController as? NavigationController
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
  }

  func bindViewModel() {}

  func setupUI() {
    view.backgroundColor = .systemBackground
  }
}
