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

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
  }

  func bindViewModel() {}

  func setupUI() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.isHidden = true
  }
}
