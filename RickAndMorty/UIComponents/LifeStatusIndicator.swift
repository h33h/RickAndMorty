//
//  LifeStatusIndicator.swift
//  RickAndMorty
//
//  Created by XXX on 28.05.22.
//

import UIKit
import RxSwift
import SnapKit

extension LifeStatus {
  var icon: UIImage {
    switch self {
    case .alive:
      let aliveImage = UIImage(named: "aliveIcon", in: Bundle(for: LifeStatusIndicator.self), with: nil) ?? UIImage()
      return aliveImage
    case .dead:
      let deadImage = UIImage(named: "deadIcon", in: Bundle(for: LifeStatusIndicator.self), with: nil) ?? UIImage()
      return deadImage
    case .unknown:
      let unknownImage = UIImage(systemName: "questionmark") ?? UIImage()
      return unknownImage
    }
  }
}

class LifeStatusIndicator: UIView {
  private lazy var icon: UIImageView = {
    let icon = UIImageView()
    icon.image = try? currentStatus.value().icon
    return icon
  }()
  private lazy var textStatus: UILabel = {
    let textStatus = UILabel()
    textStatus.text = try? currentStatus.value().rawValue
    textStatus.font = UIFont(name: "Avenir Next Medium", size: 14)
    return textStatus
  }()
  private let currentStatus = BehaviorSubject<LifeStatus>(value: .alive)
  private let disposeBag = DisposeBag()
  var isAlive: LifeStatus = .alive {
    didSet {
      switch isAlive {
      case .alive:
        currentStatus.onNext(.alive)
      case .dead:
        currentStatus.onNext(.dead)
      case .unknown:
        currentStatus.onNext(.unknown)
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupComponents()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupComponents()
  }

  func setupComponents() {
    addSubview(icon)
    icon.snp.makeConstraints { make in
      make.left.equalTo(snp.left)
      make.top.equalTo(snp.top)
      make.bottom.equalTo(snp.bottom)
      make.width.equalTo(icon.snp.height)
    }
    addSubview(textStatus)
    textStatus.snp.makeConstraints { make in
      make.left.equalTo(icon.snp.right).offset(5)
      make.top.equalTo(snp.top)
      make.bottom.equalTo(snp.bottom)
      make.right.equalTo(snp.right)
    }

    currentStatus.subscribe(onNext: { [weak self] status in
      guard let self = self else { return }
      self.icon.image = status.icon
      self.textStatus.text = status.rawValue.firstUppercased
    })
    .disposed(by: disposeBag)
  }
}
