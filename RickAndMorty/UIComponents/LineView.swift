//
//  LineView.swift
//  RickAndMorty
//
//  Created by XXX on 3.06.22.
//

import UIKit

@IBDesignable
class LineView: UIView {

  @IBInspectable lazy var color: UIColor = .black
  @IBInspectable lazy var lineWidth: CGFloat = .zero

  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else { return }
    context.setLineWidth(lineWidth)
    context.setStrokeColor(color.cgColor)
    let startingPoint = CGPoint(x: .zero, y: rect.size.height - lineWidth)
    let endingPoint = CGPoint(x: rect.size.width, y: rect.size.height - lineWidth)
    context.move(to: startingPoint )
    context.addLine(to: endingPoint )
    context.strokePath()
  }
}
