//
//  JJCircleView.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 21.11.17.
//

import UIKit

@objc open class JJCircleView: UIView {

    open var color = UIColor.defaultButtonColor {
        didSet {
            updateHighlightedColorFallback()
            setNeedsDisplay()
        }
    }

    open var highlightedColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    open var isHighlighted = false {
        didSet {
            setNeedsDisplay()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    open override func draw(_: CGRect) {
        drawCircle(inRect: bounds)
    }

    fileprivate var highlightedColorFallback = UIColor.defaultHighlightedButtonColor
}

fileprivate extension JJCircleView {

    fileprivate func setup() {
        backgroundColor = .clear
    }

    func drawCircle(inRect rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        let diameter = min(rect.width, rect.height)
        var circleRect = CGRect()
        circleRect.size.width = diameter
        circleRect.size.height = diameter
        circleRect.origin.x = (rect.width - diameter) / 2
        circleRect.origin.y = (rect.height - diameter) / 2

        let circlePath = UIBezierPath(ovalIn: circleRect)
        currentColor.setFill()
        circlePath.fill()

        context.restoreGState()
    }

    var currentColor: UIColor {
        if !isHighlighted {
            return color
        }

        if let highlightedColor = highlightedColor {
            return highlightedColor
        }

        return highlightedColorFallback
    }

    func updateHighlightedColorFallback() {
        highlightedColorFallback = color.highlighted
    }
}
