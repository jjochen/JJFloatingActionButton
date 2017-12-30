//
//  JJButtonRotationAnimation.swift
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

import UIKit

internal class JJButtonRotationAnimation {

    let actionButton: JJFloatingActionButton
    let angle: CGFloat

    init(actionButton: JJFloatingActionButton, angle: CGFloat) {
        self.actionButton = actionButton
        self.angle = angle
    }
}

extension JJButtonRotationAnimation: JJButtonAnimation {

    func open(animated: Bool, group: DispatchGroup) {
        let imageView = actionButton.imageView
        let buttonAnimation: () -> Void = {
            imageView.transform = CGAffineTransform(rotationAngle: self.angle)
        }
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: 0.55,
                       initialSpringVelocity: 0.3,
                       animations: buttonAnimation,
                       group: group,
                       animated: animated)
    }

    func close(animated: Bool, group: DispatchGroup) {
        let imageView = actionButton.imageView
        let buttonAnimations: () -> Void = {
            imageView.transform = CGAffineTransform(rotationAngle: 0)
        }
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       animations: buttonAnimations,
                       group: group,
                       animated: animated)
    }
}
