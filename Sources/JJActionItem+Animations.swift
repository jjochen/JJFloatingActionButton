//
//  JJActionItem+Animations.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 25.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import CoreGraphics
import UIKit

internal extension JJActionItem {

    func scaled(point: CGPoint, factor: CGFloat) -> CGPoint {
        let anchorPoint = CGPoint(x: bounds.width * layer.anchorPoint.x, y: bounds.height * layer.anchorPoint.y)
        let scaledX = anchorPoint.x + (point.x - anchorPoint.x) * factor
        let scaledY = anchorPoint.y + (point.y - anchorPoint.y) * factor
        let scaled = CGPoint(x: scaledX, y: scaledY)
        return scaled
    }

    func scale(factor: CGFloat = 0.4) {
        let scale = CGAffineTransform(scaleX: factor, y: factor)

        let circleCenter = circleView.center
        let circleCenterScaled = scaled(point: circleCenter, factor: factor)
        let translationX = circleCenter.x - circleCenterScaled.x
        let translationY = circleCenter.y - circleCenterScaled.y
        let translation = CGAffineTransform(translationX: translationX, y: translationY)

        let scaleAndTranslation = scale.concatenating(translation)
        transform = scaleAndTranslation
    }
}
