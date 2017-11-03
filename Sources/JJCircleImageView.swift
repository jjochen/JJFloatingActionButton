//
//  JJCircleView.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 27.10.17.
//

import UIKit
import SnapKit

internal class JJCircleImageView: UIView {
    
    internal var circleColor = UIColor(red: 0.447, green: 0.769, blue: 0.447, alpha: 1.000) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal var imageColor = UIColor.white {
        didSet {
            imageView.tintColor = imageColor
        }
    }

    internal var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    internal var isHighlighted = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func draw(_ rect: CGRect) {
        drawCircle(inRect: self.bounds)
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
    }
    
    fileprivate func drawCircle(inRect rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        let diameter = min(rect.width, rect.height)
        var circleRect = CGRect()
        circleRect.size.width = diameter
        circleRect.size.height = diameter
        circleRect.origin.x = (rect.width - diameter)/2
        circleRect.origin.y = (rect.height - diameter)/2
        
        let circlePath = UIBezierPath(ovalIn: circleRect)
        circleColor.setFill()
        circlePath.fill()
        
        context.restoreGState()
    }
    
    override func updateConstraints() {
        
        imageView.snp.remakeConstraints { make in
            let imageSizeFactor = 1/sqrt(2)
            make.center.equalTo(self)
            make.width.lessThanOrEqualTo(self.snp.width).multipliedBy(imageSizeFactor)
            make.width.lessThanOrEqualTo(self.snp.height).multipliedBy(imageSizeFactor)
            make.height.lessThanOrEqualTo(self.snp.width).multipliedBy(imageSizeFactor)
            make.height.lessThanOrEqualTo(self.snp.height).multipliedBy(imageSizeFactor)
        }
        
        super.updateConstraints()
    }
}
