//
//  JJStyles.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 27.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal class JJStyles {

    class var plusImage: UIImage? {
        if Cache.plusImage != nil {
            return Cache.plusImage
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 24, height: 24), false, 0)
        drawPlus()

        Cache.plusImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
        UIGraphicsEndImageContext()

        return Cache.plusImage
    }
}

fileprivate extension JJStyles {

    struct Cache {
        static var plusImage: UIImage?
    }

    class func drawPlus() {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        let fillColor = UIColor(red: 0.267, green: 0.267, blue: 0.267, alpha: 1.000)

        //// Bezier Drawing
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
        fillColor.setFill()
        bezierPath.fill()

        context?.restoreGState()
    }
}
