//
//  JJCircleView.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 27.10.17.
//

import UIKit

internal class JJCircleImageView: UIView {

    internal var circleColor = UIColor(hue: 0.31, saturation: 0.37, brightness: 0.76, alpha: 1.00) {
        didSet {
            updateDefaultHighligtedCircleColor()
            setNeedsDisplay()
        }
    }

    internal var highligtedCircleColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    fileprivate var defaultHighligtedCircleColor: UIColor = UIColor(hue: 0.31, saturation: 0.37, brightness: 0.66, alpha: 1.00)

    internal var imageColor = UIColor.white {
        didSet {
            imageView.tintColor = imageColor
        }
    }

    internal var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    internal var isHighlighted = false {
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

    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()

    fileprivate func setup() {
        backgroundColor = UIColor.clear
        clipsToBounds = false

        addSubview(imageView)

        let imageSizeMuliplier = CGFloat(1 / sqrt(2))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: imageSizeMuliplier).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: imageSizeMuliplier).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: imageSizeMuliplier).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: imageSizeMuliplier).isActive = true
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
        currentCircleColor.setFill()
        circlePath.fill()

        context.restoreGState()
    }

    var currentCircleColor: UIColor {
        if !isHighlighted {
            return circleColor
        }

        if let highligtedCircleColor = highligtedCircleColor {
            return highligtedCircleColor
        }

        return defaultHighligtedCircleColor
    }

    func updateDefaultHighligtedCircleColor() {
        var hue = CGFloat(0)
        var satuaration = CGFloat(0)
        var brightness = CGFloat(0)
        var alpha = CGFloat(0)
        circleColor.getHue(&hue, saturation: &satuaration, brightness: &brightness, alpha: &alpha)
        let newBrightness = brightness > 0.5 ? brightness - 0.1 : brightness + 0.1
        defaultHighligtedCircleColor = UIColor(hue: hue, saturation: satuaration, brightness: newBrightness, alpha: alpha)
    }
}
