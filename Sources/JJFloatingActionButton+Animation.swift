//
//  JJFloatingActionButton+Animation.swift
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

public extension JJFloatingActionButton {

    /// Opening style of the button itself.
    ///
    enum ButtonOpeningStyle {

        /// When opening, the button is rotated.
        ///
        /// - Parameter angle: The angle in radian the button will rotate when opening.
        ///
        case rotate(angle: CGFloat)

        /// When opening, the image view transitions to given image.
        ///
        /// - Parameter image: The image the button will show when opening.
        ///
        case transition(image: UIImage)
    }

    /// Opening style of the action items.
    ///
    enum ItemOpeningStyle {

        /// When opening, items "pop up" one after the other in a vertical line.
        ///
        /// - Parameter interItemSpacing: The distance in points between two adjacent action items.
        ///
        case popUp(interItemSpacing: CGFloat)

        /// When opening, items "slide in" from the side one after the other in a vertical line.
        ///
        /// - Parameter interItemSpacing: The distance in points between two adjacent action items.
        ///
        case slideIn(interItemSpacing: CGFloat, distance: CGFloat)

        /// When opening, items "pop up" one after the other in a circle around the action button.
        ///
        /// - Parameter radius: The distance in points between the center of an action item and the center of the button.
        ///
        case circularPop(radius: CGFloat)

        /// When opening, items "slide in" one after the other in a circle around the action button.
        ///
        /// - Parameter radius: The distance in points between the center of an action item and the center of the button.
        ///
        case circularSlideIn(radius: CGFloat, distance: CGFloat)
    }
}

@objc public extension JJFloatingActionButton {

    /// Open the floating action button and show all action items.
    ///
    /// - Parameter animated: When true, button will be opened with an animation. Default is `true`.
    /// - Parameter completion: Will be handled upon completion. Default is `nil`.
    ///
    /// - Remark: Hidden items and items that have user interaction disabled are omitted.
    ///
    func open(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard buttonState == .closed else {
            return
        }
        guard let superview = superview else {
            return
        }
        guard !enabledItems.isEmpty else {
            return
        }
        guard !isSingleActionButton else {
            return
        }

        buttonState = .opening
        delegate?.floatingActionButtonWillOpen?(self)

        animationConfiguration = AnimationConfiguration(items: enabledItems,
                                                        buttonOpeningStyle: buttonOpeningStyle,
                                                        itemOpeningStyle: itemOpeningStyle)

        superview.bringSubview(toFront: self)
        addOverlayView(to: superview)
        addItems(to: superview)
        itemContainerView.setNeedsLayout()
        itemContainerView.layoutIfNeeded()

        let animationGroup = DispatchGroup()

        showOverlay(animated: animated, group: animationGroup)
        openButton(animated: animated, group: animationGroup)
        openItems(animated: animated, group: animationGroup)

        let groupCompletion: () -> Void = {
            self.buttonState = .open
            self.delegate?.floatingActionButtonDidOpen?(self)
            completion?()
        }
        if animated {
            animationGroup.notify(queue: .main, execute: groupCompletion)
        } else {
            groupCompletion()
        }
    }

    /// Close the floating action button and hide all action items.
    ///
    /// - Parameter animated: When true, button will be close with an animation. Default is `true`.
    /// - Parameter completion: Will be handled upon completion. Default is `nil`.
    ///
    func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard buttonState == .open else {
            return
        }
        buttonState = .closing
        delegate?.floatingActionButtonWillClose?(self)
        overlayView.isEnabled = false

        let animationGroup = DispatchGroup()

        hideOverlay(animated: animated, group: animationGroup)
        closeButton(animated: animated, group: animationGroup)
        closeItems(animated: animated, group: animationGroup)

        let groupCompletion: () -> Void = {
            self.animationConfiguration?.items.forEach { item in
                item.removeFromSuperview()
            }
            self.animationConfiguration = nil
            self.itemContainerView.removeFromSuperview()
            self.buttonState = .closed
            self.delegate?.floatingActionButtonDidClose?(self)
            completion?()
        }
        if animated {
            animationGroup.notify(queue: .main, execute: groupCompletion)
        } else {
            groupCompletion()
        }
    }
}

// MARK: - Animation Configuration

internal extension JJFloatingActionButton {
    struct AnimationConfiguration {
        let items: [JJActionItem]
        let buttonOpeningStyle: ButtonOpeningStyle
        let itemOpeningStyle: ItemOpeningStyle
    }
}

// MARK: - Overlay Animation

fileprivate extension JJFloatingActionButton {

    func addOverlayView(to superview: UIView) {
        overlayView.isEnabled = true
        superview.insertSubview(overlayView, belowSubview: self)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        overlayView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }

    func showOverlay(animated: Bool, group: DispatchGroup) {
        let buttonAnimation: () -> Void = {
            self.overlayView.alpha = 1
        }
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.3,
                       animations: buttonAnimation,
                       group: group,
                       animated: animated)
    }

    func hideOverlay(animated: Bool, group: DispatchGroup) {
        let animations: () -> Void = {
            self.overlayView.alpha = 0
        }
        let completion: (Bool) -> Void = { _ in
            self.overlayView.removeFromSuperview()
        }
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.8,
                       animations: animations,
                       completion: completion,
                       group: group,
                       animated: animated)
    }
}

// MARK: - Button Animation

fileprivate extension JJFloatingActionButton {

    func openButton(animated: Bool, group: DispatchGroup) {
        precondition(animationConfiguration != nil)

        switch animationConfiguration!.buttonOpeningStyle {
        case let .rotate(angle):
            rotateButton(angle: angle,
                         fast: false,
                         group: group,
                         animated: animated)
        case let .transition(image):
            transistion(to: image,
                        animated: animated,
                        group: group)
        }
    }

    func closeButton(animated: Bool, group: DispatchGroup) {
        precondition(animationConfiguration != nil)

        switch animationConfiguration!.buttonOpeningStyle {
        case .rotate:
            rotateButton(angle: 0,
                         fast: true,
                         group: group,
                         animated: animated)
        case .transition:
            transistion(to: currentButtonImage,
                        animated: animated,
                        group: group)
        }
    }

    func rotateButton(angle: CGFloat,
                      fast: Bool,
                      group: DispatchGroup,
                      animated: Bool) {

        let animation: () -> Void = {
            self.imageView.transform = CGAffineTransform(rotationAngle: angle)
        }

        let dampingRatio: CGFloat = fast ? 0.6 : 0.55
        let velocity: CGFloat = fast ? 0.8 : 0.3
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: dampingRatio,
                       initialSpringVelocity: velocity,
                       animations: animation,
                       group: group,
                       animated: animated)
    }

    func transistion(to image: UIImage?, animated: Bool, group: DispatchGroup) {
        let transition: () -> Void = {
            self.imageView.image = image
        }
        UIView.transition(with: imageView,
                          duration: 0.3,
                          animations: transition,
                          group: group,
                          animated: animated)
    }
}

// MARK: - Items Animation

fileprivate extension JJFloatingActionButton {

    func addItems(to superview: UIView) {
        precondition(animationConfiguration != nil)
        let configuration = animationConfiguration!

        superview.insertSubview(itemContainerView, belowSubview: self)

        configuration.items.forEach { item in
            item.alpha = 0
            item.transform = .identity
            itemContainerView.addSubview(item)

            item.translatesAutoresizingMaskIntoConstraints = false

            item.circleView.heightAnchor.constraint(equalTo: circleView.heightAnchor,
                                                    multiplier: itemSizeRatio).isActive = true

            item.topAnchor.constraint(greaterThanOrEqualTo: itemContainerView.topAnchor).isActive = true
            item.leadingAnchor.constraint(greaterThanOrEqualTo: itemContainerView.leadingAnchor).isActive = true
            item.trailingAnchor.constraint(lessThanOrEqualTo: itemContainerView.trailingAnchor).isActive = true
            item.bottomAnchor.constraint(lessThanOrEqualTo: itemContainerView.bottomAnchor).isActive = true
        }

        layout(items: configuration.items, forStyle: configuration.itemOpeningStyle)
    }

    func openItems(animated: Bool, group: DispatchGroup) {
        precondition(animationConfiguration != nil)
        let configuration = animationConfiguration!

        let numberOfItems = configuration.items.count
        var delay: TimeInterval = 0.0
        var index = 0
        for item in configuration.items {
            prepareItemForClosedState(item, atIndex: index, numberOfItems: numberOfItems, style: configuration.itemOpeningStyle)
            let animation: () -> Void = {
                self.prepareItemForOpenState(item, style: configuration.itemOpeningStyle)
            }
            UIView.animate(duration: 0.3,
                           delay: delay,
                           usingSpringWithDamping: 0.55,
                           initialSpringVelocity: 0.3,
                           animations: animation,
                           group: group,
                           animated: animated)

            delay += interItemDelay(forStyle: configuration.itemOpeningStyle)
            index += 1
        }
    }

    func closeItems(animated: Bool, group: DispatchGroup) {
        precondition(animationConfiguration != nil)
        let configuration = animationConfiguration!

        let numberOfItems = configuration.items.count
        var delay: TimeInterval = 0.0
        var index = numberOfItems - 1
        for item in configuration.items.reversed() {
            let animation: () -> Void = {
                self.prepareItemForClosedState(item, atIndex: index, numberOfItems: numberOfItems, style: configuration.itemOpeningStyle)
            }
            UIView.animate(duration: 0.15,
                           delay: delay,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.8,
                           animations: animation,
                           group: group,
                           animated: animated)

            delay += interItemDelay(forStyle: configuration.itemOpeningStyle)
            index -= 1
        }
    }

    func layout(items: [JJActionItem], forStyle style: ItemOpeningStyle) {
        switch style {
        case let .popUp(interItemSpacing):
            layoutItemsInVerticalLine(items, interItemSpacing: interItemSpacing)
        case let .slideIn(interItemSpacing, _):
            layoutItemsInVerticalLine(items, interItemSpacing: interItemSpacing)
        case let .circularPop(radius):
            layoutItemsInCircle(items, radius: radius)
        case let .circularSlideIn(radius, _):
            layoutItemsInCircle(items, radius: radius)
        }
    }

    func prepareItemForClosedState(_ item: JJActionItem, atIndex index: Int, numberOfItems: Int, style: ItemOpeningStyle) {
        switch style {
        case .popUp:
            item.scale(by: 0.4)
        case .slideIn:
            let offset: CGFloat = item.isTitleOnTheRight ? -50 : 50
            let point = item.circleView.center.applying(CGAffineTransform(translationX: offset, y: 0))
            item.scale(by: 0.4, translateCircleCenterTo: point)
        case .circularPop:
            item.scale(by: 0.4)
        case let .circularSlideIn(_, distance):
            let angle = angleForItem(at: index, numberOfItems: numberOfItems) + .pi
            let dx = distance * cos(angle)
            let dy = distance * sin(angle)
            let point = item.circleView.center.applying(CGAffineTransform(translationX: dx, y: dy))
            item.scale(by: 0.4, translateCircleCenterTo: point)
        }
        item.alpha = 0
    }

    func prepareItemForOpenState(_ item: JJActionItem, style _: ItemOpeningStyle) {
        item.transform = .identity
        item.alpha = 1
    }

    func interItemDelay(forStyle style: ItemOpeningStyle) -> TimeInterval {
        switch style {
        case .circularPop:
            return 0.05
        default:
            return 0.1
        }
    }

    func layoutItemsInVerticalLine(_ items: [JJActionItem], interItemSpacing: CGFloat) {
        var previousItem: JJActionItem?
        for item in items {
            let previousView = previousItem ?? circleView
            item.bottomAnchor.constraint(equalTo: previousView.topAnchor, constant: -interItemSpacing).isActive = true
            item.circleView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
            previousItem = item
        }
    }

    func layoutItemsInCircle(_ items: [JJActionItem], radius: CGFloat) {
        let numberOfItems = items.count
        var index: Int = 0
        for item in items {
            let angle = angleForItem(at: index, numberOfItems: numberOfItems)
            let dx = radius * cos(angle)
            let dy = radius * sin(angle)

            item.circleView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor, constant: dx).isActive = true
            item.circleView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: dy).isActive = true

            index += 1
        }
    }

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

// MARK: - Objective-C setters for opening styles

@objc public extension JJFloatingActionButton {

    /// Sets `buttonOpeningStyle` to `.rotate(angle:)` with given angle.
    ///
    /// - Parameter angle: The angle in radian the button will rotate when opening.
    ///
    /// - Remark: Should not be used in swift. Set `buttonOpeningStyle` directly instead.
    ///
    /// - SeeAlso: `buttonOpeningStyle`.
    ///
    func useButtonOpeningStyleRotate(angle: CGFloat) {
        buttonOpeningStyle = .rotate(angle: angle)
    }

    /// Sets `buttonOpeningStyle` to `.transition(image:)` with given image.
    ///
    /// - Parameter image: The image the button will show when opening.
    ///
    /// - Remark: Should not be used in swift. Set `buttonOpeningStyle` directly instead.
    ///
    /// - SeeAlso: `buttonOpeningStyle`.
    ///
    func useButtonOpeningStyleTransition(image: UIImage) {
        buttonOpeningStyle = .transition(image: image)
    }

    /// Sets `itemOpeningStyle` to `.popUp(interItemSpacing:)` with given inter item spacing.
    ///
    /// - Parameter interItemSpacing: The distance in points between two adjacent action items.
    ///
    /// - Remark: Should not be used in swift. Set `itemOpeningStyle` directly instead.
    ///
    /// - SeeAlso: `itemOpeningStyle`.
    ///
    func useItemOpeningStylePopUp(interItemSpacing: CGFloat) {
        itemOpeningStyle = .popUp(interItemSpacing: interItemSpacing)
    }

    /// Sets `itemOpeningStyle` to `.slideIn(interItemSpacing:distance:)` with given inter item spacing.
    ///
    /// - Parameter interItemSpacing: The distance in points between two adjacent action items.
    ///
    /// - Remark: Should not be used in swift. Set `itemOpeningStyle` directly instead.
    ///
    /// - SeeAlso: `itemOpeningStyle`.
    ///
    func useItemOpeningStyleSlideIn(interItemSpacing: CGFloat, distance: CGFloat) {
        itemOpeningStyle = .slideIn(interItemSpacing: interItemSpacing, distance: distance)
    }

    /// Sets `itemOpeningStyle` to `.circularPop(radius:)` with given radius.
    ///
    /// - Parameter radius: The distance in points between the center of an action item and the center of the button.
    ///
    /// - Remark: Should not be used in swift. Set `itemOpeningStyle` directly instead.
    ///
    /// - SeeAlso: `itemOpeningStyle`.
    ///
    func useItemOpeningStyleCircularPop(radius: CGFloat) {
        itemOpeningStyle = .circularPop(radius: radius)
    }

    /// Sets `itemOpeningStyle` to `.circularSlideIn(radius:distance:)` with given radius.
    ///
    /// - Parameter radius: The distance in points between the center of an action item and the center of the button.
    ///
    /// - Remark: Should not be used in swift. Set `itemOpeningStyle` directly instead.
    ///
    /// - SeeAlso: `itemOpeningStyle`.
    ///
    func useItemOpeningStyleCircularSlideIn(radius: CGFloat, distance: CGFloat) {
        itemOpeningStyle = .circularSlideIn(radius: radius, distance: distance)
    }
}
