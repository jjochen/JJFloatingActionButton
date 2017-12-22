//
//  JJButtonRotationAnimation.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 22.12.17.
//

import Foundation

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
        let imageView = self.actionButton.imageView;
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
        let imageView = self.actionButton.imageView;
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
