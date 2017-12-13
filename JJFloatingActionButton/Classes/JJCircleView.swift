//
//  JJCircleView.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 21.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

/// A colored circle with an highlighted state
///
@objc @IBDesignable open class JJCircleView: UIView {

    /// The color of the circle.
    ///
    @objc @IBInspectable open var color: UIColor = .defaultButtonColor {
        didSet {
            updateHighlightedColorFallback()
            setNeedsDisplay()
        }
    }

    /// The color of the circle when highlighted. Default is `nil`.
    ///
    @objc @IBInspectable open var highlightedColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    /// Highlighted state. Default is `false`.
    ///
    @objc open var isHighlighted = false {
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

// MARK: - Private Methods

fileprivate extension JJCircleView {

    func setup() {
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
