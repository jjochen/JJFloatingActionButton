//
//  JJCircleView.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 27.10.17.
//

import UIKit

internal class JJCircleImageView: UIView {

    internal var circleColor = UIColor.defaultButtonColor {
        didSet {
            updateHighligtedCircleColorFallback()
            configureCircleView()
        }
    }

    internal var highligtedCircleColor: UIColor? {
        didSet {
            configureCircleView()
        }
    }


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
            configureCircleView()
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
    
    fileprivate(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    fileprivate lazy var circleView: JJCircleView = {
        let circleView = JJCircleView()
        circleView.color = currentCircleColor
        return circleView
    }()

    fileprivate var highligtedCircleColorFallback: UIColor = UIColor(hue: 0.31, saturation: 0.37, brightness: 0.66, alpha: 1.00)
}

fileprivate extension JJCircleImageView {
    
    func setup() {
        backgroundColor = .clear
        clipsToBounds = false
        isUserInteractionEnabled = false
        
        addSubview(circleView)
        addSubview(imageView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        circleView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor).isActive = true
        circleView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor).isActive = true
        let circleWidth = circleView.widthAnchor.constraint(equalTo: widthAnchor)
        circleWidth.priority = .defaultHigh
        circleWidth.isActive = true
        let circleHeight = circleView.heightAnchor.constraint(equalTo: heightAnchor)
        circleHeight.priority = .defaultHigh
        circleHeight.isActive = true
        
        let imageSizeMuliplier = CGFloat(1 / sqrt(2))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: circleView.widthAnchor, multiplier: imageSizeMuliplier).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualTo: circleView.heightAnchor, multiplier: imageSizeMuliplier).isActive = true
    }
    
    func configureCircleView() {
        circleView.color = currentCircleColor
    }
    
    var currentCircleColor: UIColor {
        if !isHighlighted {
            return circleColor
        }
        
        if let highligtedCircleColor = highligtedCircleColor {
            return highligtedCircleColor
        }
        
        return highligtedCircleColorFallback
    }
    
    func updateHighligtedCircleColorFallback() {
        var hue = CGFloat(0)
        var satuaration = CGFloat(0)
        var brightness = CGFloat(0)
        var alpha = CGFloat(0)
        circleColor.getHue(&hue, saturation: &satuaration, brightness: &brightness, alpha: &alpha)
        let newBrightness = brightness > 0.5 ? brightness - 0.1 : brightness + 0.1
        highligtedCircleColorFallback = UIColor(hue: hue, saturation: satuaration, brightness: newBrightness, alpha: alpha)
    }
}
