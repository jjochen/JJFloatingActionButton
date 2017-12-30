//
//  JJStyles.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 27.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal struct JJStyles {
}

// MARK: - Colors

internal extension JJStyles {

    static var defaultButtonColor: UIColor {
        return UIColor(hue: 0.31, saturation: 0.37, brightness: 0.76, alpha: 1.00)
    }

    static var defaultHighlightedButtonColor: UIColor {
        return UIColor(hue: 0.31, saturation: 0.37, brightness: 0.66, alpha: 1.00)
    }
}

// MARK: - Images

internal extension JJStyles {

    static var plusImage: UIImage? {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 22.5, y: 11))
        bezierPath.addLine(to: CGPoint(x: 13, y: 11))
        bezierPath.addLine(to: CGPoint(x: 13, y: 1.5))
        bezierPath.addCurve(to: CGPoint(x: 12.5, y: 1), controlPoint1: CGPoint(x: 13, y: 1.22), controlPoint2: CGPoint(x: 12.78, y: 1))
        bezierPath.addLine(to: CGPoint(x: 11.5, y: 1))
        bezierPath.addCurve(to: CGPoint(x: 11, y: 1.5), controlPoint1: CGPoint(x: 11.22, y: 1), controlPoint2: CGPoint(x: 11, y: 1.22))
        bezierPath.addLine(to: CGPoint(x: 11, y: 11))
        bezierPath.addLine(to: CGPoint(x: 1.5, y: 11))
        bezierPath.addCurve(to: CGPoint(x: 1, y: 11.5), controlPoint1: CGPoint(x: 1.22, y: 11), controlPoint2: CGPoint(x: 1, y: 11.22))
        bezierPath.addLine(to: CGPoint(x: 1, y: 12.5))
        bezierPath.addCurve(to: CGPoint(x: 1.5, y: 13), controlPoint1: CGPoint(x: 1, y: 12.78), controlPoint2: CGPoint(x: 1.22, y: 13))
        bezierPath.addLine(to: CGPoint(x: 11, y: 13))
        bezierPath.addLine(to: CGPoint(x: 11, y: 22.5))
        bezierPath.addCurve(to: CGPoint(x: 11.5, y: 23), controlPoint1: CGPoint(x: 11, y: 22.78), controlPoint2: CGPoint(x: 11.22, y: 23))
        bezierPath.addLine(to: CGPoint(x: 12.5, y: 23))
        bezierPath.addCurve(to: CGPoint(x: 13, y: 22.5), controlPoint1: CGPoint(x: 12.78, y: 23), controlPoint2: CGPoint(x: 13, y: 22.78))
        bezierPath.addLine(to: CGPoint(x: 13, y: 13))
        bezierPath.addLine(to: CGPoint(x: 22.5, y: 13))
        bezierPath.addCurve(to: CGPoint(x: 23, y: 12.5), controlPoint1: CGPoint(x: 22.78, y: 13), controlPoint2: CGPoint(x: 23, y: 12.78))
        bezierPath.addLine(to: CGPoint(x: 23, y: 11.5))
        bezierPath.addCurve(to: CGPoint(x: 22.5, y: 11), controlPoint1: CGPoint(x: 23, y: 11.22), controlPoint2: CGPoint(x: 22.78, y: 11))
        bezierPath.close()

        return image(for: bezierPath, size: CGSize(width: 24, height: 24), name: "plus")
    }
}

// MARK: - Helper

fileprivate extension JJStyles {

    static var cache = NSCache<NSString, UIImage>()

    static func image(for path: UIBezierPath, size: CGSize, name: NSString) -> UIImage? {
        var image = cache.object(forKey: name)
        if image == nil {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            draw(path)
            image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
            UIGraphicsEndImageContext()
            if let image = image {
                cache.setObject(image, forKey: name)
            }
        }
        return image
    }

    static func draw(_ path: UIBezierPath) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let fillColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1.000)
        fillColor.setFill()
        path.fill()
        context?.restoreGState()
    }
}
