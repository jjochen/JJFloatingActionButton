//
//  JJItemSlideAnimation.swift
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

internal class JJItemSlideAnimation {

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

    fileprivate var containerView: UIView?
}

extension JJItemSlideAnimation: JJItemAnimation {

    func addItems(to containerView: UIView) {

        self.containerView = containerView

        var previousItem: JJActionItem?
        for item in items {
            let previousView = previousItem ?? actionButton.circleView
            item.alpha = 0
            item.transform = .identity
            containerView.addSubview(item)

            item.translatesAutoresizingMaskIntoConstraints = false
            item.circleView.heightAnchor.constraint(equalTo: actionButton.circleView.heightAnchor,
                                                    multiplier: itemSizeRatio).isActive = true
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

        items.forEach { item in
            let point = item.circleView.center.applying(CGAffineTransform(translationX: 50, y: 0))
            item.scale(by: 0.4, translateCircleCenterTo: point)
            item.alpha = 0
        }

        let animation: () -> Void = {
            self.items.forEach { item in
                item.transform = .identity
                item.alpha = 1
            }
        }
        UIView.animate(duration: 0.5,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.3,
                       animations: animation,
                       group: group,
                       animated: animated)
    }

    func close(animated: Bool, group: DispatchGroup) {
        let animation: () -> Void = {
            self.items.forEach { item in
                let point = item.circleView.center.applying(CGAffineTransform(translationX: 50, y: 0))
                item.scale(by: 0.4, translateCircleCenterTo: point)
                item.alpha = 0
            }
        }
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       animations: animation,
                       group: group,
                       animated: animated)
    }

    func removeItems() {
        items.forEach { item in
            item.removeFromSuperview()
        }
    }
}
