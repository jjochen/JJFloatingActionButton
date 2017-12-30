//
//  JJItemPopAnimation.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 22.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal class JJItemPopAnimation {

    let actionButton: JJFloatingActionButton
    let items: [JJActionItem]
    let itemSizeRatio: CGFloat
    let interItemSpacing: CGFloat

    init(actionButton: JJFloatingActionButton, items: [JJActionItem], itemSizeRatio: CGFloat, interItemSpacing: CGFloat) {
        self.actionButton = actionButton
        self.items = items
        self.itemSizeRatio = itemSizeRatio
        self.interItemSpacing = interItemSpacing
    }
}

extension JJItemPopAnimation: JJItemAnimation {

    func addItems(to containerView: UIView) {

        var previousItem: JJActionItem?
        for item in items {
            let previousView = previousItem ?? actionButton.circleView
            item.alpha = 0
            item.transform = .identity
            containerView.addSubview(item)

            item.translatesAutoresizingMaskIntoConstraints = false
            item.heightAnchor.constraint(equalTo: actionButton.circleView.heightAnchor, multiplier: itemSizeRatio).isActive = true
            item.bottomAnchor.constraint(equalTo: previousView.topAnchor, constant: -interItemSpacing).isActive = true
            item.circleView.centerXAnchor.constraint(equalTo: actionButton.circleView.centerXAnchor).isActive = true
            item.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor).isActive = true
            item.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor).isActive = true
            item.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor).isActive = true
            item.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor).isActive = true

            previousItem = item
        }
    }

    func open(animated: Bool, group: DispatchGroup) {
        var delay = 0.0
        for item in items {
            item.scale()
            let animation: () -> Void = {
                item.transform = .identity
                item.alpha = 1
            }
            UIView.animate(duration: 0.3,
                           delay: delay,
                           usingSpringWithDamping: 0.55,
                           initialSpringVelocity: 0.3,
                           animations: animation,
                           group: group,
                           animated: animated)

            delay += 0.1
        }
    }

    func close(animated: Bool, group: DispatchGroup) {
        var delay = 0.0
        for item in items.reversed() {
            let animation: () -> Void = {
                item.scale()
                item.alpha = 0
            }
            UIView.animate(duration: 0.15,
                           delay: delay,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.8,
                           animations: animation,
                           group: group,
                           animated: animated)

            delay += 0.1
        }
    }

    func removeItems() {
        items.forEach { item in
            item.removeFromSuperview()
        }
    }
}
