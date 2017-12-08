//
//  UIView+Extensions.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 07.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal extension UIView {

    static func animate(duration: TimeInterval,
                        delay: TimeInterval = 0,
                        usingSpringWithDamping dampingRatio: CGFloat,
                        initialSpringVelocity velocity: CGFloat,
                        options: UIViewAnimationOptions = [.beginFromCurrentState],
                        animations: @escaping () -> Void,
                        completion: ((Bool) -> Void)? = nil, group: DispatchGroup? = nil, animated: Bool = true) {

        let groupedAnimations: () -> Void = {
            group?.enter()
            animations()
        }
        let groupedCompletion: (Bool) -> Void = { finished in
            completion?(finished)
            group?.leave()
        }

        if animated {
            UIView.animate(withDuration: duration,
                           delay: delay,
                           usingSpringWithDamping: dampingRatio,
                           initialSpringVelocity: velocity,
                           options: options,
                           animations: groupedAnimations,
                           completion: groupedCompletion)
        } else {
            groupedAnimations()
            groupedCompletion(true)
        }
    }
}
