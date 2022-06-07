//
//  MenuViewController.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MenuViewController: TabBarController {
  private enum Constants {
    static var sortButtonImage = UIImage(systemName: "arrow.up.arrow.down.circle")
  }
  private(set) lazy var sortButton: UIButton = {
    let sortButton = UIButton()
    sortButton.setImage(Constants.sortButtonImage, for: .normal)
    sortButton.tintColor = .appCyan
    return sortButton
  }()

  var viewModel: MenuViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    navi?.addActionButton(sortButton)
    navi?.setTitle("Rick and Morty")
  }

  override func bindViewModel() {
    super.bindViewModel()
  }
}
