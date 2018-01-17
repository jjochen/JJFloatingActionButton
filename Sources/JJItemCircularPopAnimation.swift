//
//  JJItemCircularPopAnimation.swift
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

internal class JJItemCircularPopAnimation {

    let actionButton: JJFloatingActionButton
    let items: [JJActionItem]
    let itemSizeRatio: CGFloat
    let radius: CGFloat

    init(actionButton: JJFloatingActionButton, items: [JJActionItem], itemSizeRatio: CGFloat, radius: CGFloat) {
        self.actionButton = actionButton
        self.items = items
        self.itemSizeRatio = itemSizeRatio
        self.radius = radius
    }
}

extension JJItemCircularPopAnimation: JJItemAnimation {

    func addItems(to containerView: UIView) {
        let numberOfItems = items.count

        var index = 0
        for item in items {
            item.alpha = 0
            item.transform = .identity
            containerView.addSubview(item)

            item.translatesAutoresizingMaskIntoConstraints = false
            item.heightAnchor.constraint(equalTo: actionButton.circleView.heightAnchor, multiplier: itemSizeRatio).isActive = true
            item.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor).isActive = true
            item.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor).isActive = true
            item.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor).isActive = true
            item.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor).isActive = true

            let angle = angleForItem(at: index, numberOfItems: numberOfItems)
            let dx = radius * cos(angle)
            let dy = radius * sin(angle)

            item.circleView.centerXAnchor.constraint(equalTo: actionButton.circleView.centerXAnchor, constant: dx).isActive = true
            item.circleView.centerYAnchor.constraint(equalTo: actionButton.circleView.centerYAnchor, constant: dy).isActive = true

            index += 1
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

// MARK: - Helper

fileprivate extension JJItemCircularPopAnimation {

    func angleForItem(at index: Int, numberOfItems: Int) -> CGFloat {
        let minAngle = CGFloat.pi
        let maxAngle = CGFloat.pi * 1.5

        var interItemAngle: CGFloat
        switch numberOfItems {
        case 1:
            interItemAngle = 0
        case 2:
            interItemAngle = (maxAngle - minAngle) * 0.8
        default:
            interItemAngle = (maxAngle - minAngle) / (CGFloat(numberOfItems) - 1)
        }

        let marginAngle = ((maxAngle - minAngle) - interItemAngle * (CGFloat(numberOfItems) - 1)) / 2
        let angle = minAngle + marginAngle + CGFloat(index) * interItemAngle

        return angle
    }
}
