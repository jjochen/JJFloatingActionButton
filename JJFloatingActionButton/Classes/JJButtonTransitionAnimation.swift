//
//  JJButtonTransitionAnimation.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 22.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal class JJButtonTransitionAnimation {

    let actionButton: JJFloatingActionButton
    let openImage: UIImage
    let closeImage: UIImage?

    init(actionButton: JJFloatingActionButton, openImage: UIImage, closeImage: UIImage?) {
        self.actionButton = actionButton
        self.openImage = openImage
        self.closeImage = closeImage
    }
}

extension JJButtonTransitionAnimation: JJButtonAnimation {

    func open(animated: Bool, group: DispatchGroup) {
        let imageView = actionButton.imageView
        let transition: () -> Void = {
            imageView.image = self.openImage
        }
        UIView.transition(with: imageView,
                          duration: 0.2,
                          animations: transition,
                          group: group,
                          animated: animated)
    }

    func close(animated: Bool, group: DispatchGroup) {
        let imageView = actionButton.imageView
        let transition: () -> Void = {
            imageView.image = self.closeImage
        }
        UIView.transition(with: imageView,
                          duration: 0.2,
                          animations: transition,
                          group: group,
                          animated: animated)
    }
}
