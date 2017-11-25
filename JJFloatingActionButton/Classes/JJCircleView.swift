//
//  JJCircleView.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 21.11.17.
//

import UIKit

internal class JJCircleView: UIView {

    internal var color = UIColor.defaultButtonColor {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    open override func draw(_: CGRect) {
        drawCircle(inRect: bounds)
    }

    fileprivate func setup() {
        backgroundColor = .clear
    }

    fileprivate func drawCircle(inRect rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        let diameter = min(rect.width, rect.height)
        var circleRect = CGRect()
        circleRect.size.width = diameter
        circleRect.size.height = diameter
        circleRect.origin.x = (rect.width - diameter) / 2
        circleRect.origin.y = (rect.height - diameter) / 2

        let circlePath = UIBezierPath(ovalIn: circleRect)
        color.setFill()
        circlePath.fill()

        context.restoreGState()
    }
}
