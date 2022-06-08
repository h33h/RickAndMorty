//
//  FilterView.swift
//  RickAndMorty
//
//  Created by XXX on 7.06.22.
//

import UIKit
import SnapKit

class FilterView: UIView {
  private lazy var backgroundView = UIView()
  private lazy var titleText = UILabel()
  func setupUI() {
    addSubview(backgroundView)
    backgroundView.snp.makeConstraints { make in
      make.edges.equalTo(snp.edges)
    }
  }
}
