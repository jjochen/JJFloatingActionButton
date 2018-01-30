//
//  JJActionItem+Animations.swift
//
//  Copyright (c) 2017-Present Jochen Pfeiffer
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import CoreGraphics
import UIKit

internal extension JJActionItem {

    func scale(by factor: CGFloat) {
        let unscaledCircleCenter = circleView.center
        scale(by: factor, translateCircleCenterTo: unscaledCircleCenter)
    }

    func scale(by factor: CGFloat, translateCircleCenterTo point: CGPoint) {
        let scale = CGAffineTransform(scaleX: factor, y: factor)

        let circleCenter = circleView.center
        let circleCenterScaled = scaled(point: circleCenter, factor: factor)
        let translationX = point.x - circleCenterScaled.x
        let translationY = point.y - circleCenterScaled.y
        let translation = CGAffineTransform(translationX: translationX, y: translationY)

        let scaleAndTranslation = scale.concatenating(translation)
        transform = scaleAndTranslation
    }
}

fileprivate extension JJActionItem {

    func scaled(point: CGPoint, factor: CGFloat) -> CGPoint {
        let anchorPoint = CGPoint(x: bounds.width * layer.anchorPoint.x, y: bounds.height * layer.anchorPoint.y)
        let scaledX = anchorPoint.x + (point.x - anchorPoint.x) * factor
        let scaledY = anchorPoint.y + (point.y - anchorPoint.y) * factor
        let scaled = CGPoint(x: scaledX, y: scaledY)
        return scaled
    }
}
