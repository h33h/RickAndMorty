//
//  TabBarItemView.swift
//  RickAndMorty
//
//  Created by XXX on 26.05.22.
//

import RxGesture
import RxSwift
import UIKit

protocol TabBarItemViewDelegate: AnyObject {
  func didSelect(_ tabBarItemView: TabBarItemView)
}

class TabBarItemView: UIView {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var backgroundView: UIView!

  private let disposeBag = DisposeBag()
  private lazy var state: TabBarItemState = TabBarItemNotSelectedState(to: self)
  private(set) var content: TabBarItemContent?

  weak var delegate: TabBarItemViewDelegate?

  static func instantiate(with content: TabBarItemContent) -> TabBarItemView {
    guard let instance = Bundle.main.loadNibNamed(
      String(describing: TabBarItemView.self),
      owner: nil,
      options: nil
    )?.first as? TabBarItemView else {
      fatalError("CustomTabBarItemView not found")
    }
    instance.content = content
    instance.state.updateUI()
    return instance
  }

  func switchState(with state: TabBarItemState) {
    self.state = state
    state.updateUI()
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    addTapGesture()
  }

  override func updateConstraints() {
    super.updateConstraints()
    backgroundView.layer.cornerRadius = backgroundView.frame.height / 4
  }
}

extension TabBarItemView {
  func addTapGesture() {
    rx
    .tapGesture()
    .when(.recognized)
    .subscribe(onNext: { [weak self] _ in
      guard let self = self else { return }
      if self.state is TabBarItemNotSelectedState {
        self.switchState(with: TabBarItemSelectedState(tabBarItemView: self))
        self.delegate?.didSelect(self)
      }
    })
    .disposed(by: disposeBag)
  }
}
