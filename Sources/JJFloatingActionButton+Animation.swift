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

        /// When opening, items "pop up" one after the other in a circle around the action button.
        ///
        /// - Parameter radius: The distance in points between the center of an action item and the center of the button.
        ///
        case circularPop(radius: CGFloat)
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
        guard !items.isEmpty else {
            return
        }
        guard !isSingleActionButton else {
            return
        }

        buttonState = .opening
        delegate?.floatingActionButtonWillOpen?(self)

        itemAnimation = currentItemAnimation

        superview.bringSubview(toFront: self)
        addOverlayView(to: superview)
        superview.insertSubview(itemContainerView, belowSubview: self)

        itemAnimation?.addItems(to: itemContainerView)
        itemContainerView.setNeedsLayout()
        itemContainerView.layoutIfNeeded()

        let animationGroup = DispatchGroup()

        showOverlay(animated: animated, group: animationGroup)
        openButton(animated: animated, group: animationGroup)
        itemAnimation?.open(animated: animated, group: animationGroup)

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
        itemAnimation?.close(animated: animated, group: animationGroup)

        let groupCompletion: () -> Void = {
            self.itemAnimation?.removeItems()
            self.itemAnimation = nil
            self.itemContainerView.removeFromSuperview()
            self.currentButtonOpeningStyle = nil
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

// MARK: - Overlay Animation

internal extension JJFloatingActionButton {

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

internal extension JJFloatingActionButton {

    func openButton(animated: Bool, group: DispatchGroup) {
        currentButtonOpeningStyle = buttonOpeningStyle
        switch buttonOpeningStyle {
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
        precondition(currentButtonOpeningStyle != nil)

        switch currentButtonOpeningStyle! {
        case let .rotate(_):
            rotateButton(angle: 0,
                         fast: true,
                         group: group,
                         animated: animated)
        case let .transition(_):
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

internal extension JJFloatingActionButton {

    var currentItemAnimation: JJItemAnimation {
        let itemAnimation: JJItemAnimation
        switch itemOpeningStyle {

        case let .popUp(interItemSpacing):
            itemAnimation = JJItemPopAnimation(actionButton: self,
                                               items: enabledItems,
                                               itemSizeRatio: itemSizeRatio,
                                               interItemSpacing: interItemSpacing)
        case let .circularPop(radius):
            itemAnimation = JJItemCircularPopAnimation(actionButton: self,
                                                       items: enabledItems,
                                                       itemSizeRatio: itemSizeRatio,
                                                       radius: radius)
        }

        return itemAnimation
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
}
