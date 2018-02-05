//
//  AnimationConfiguration.swift
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

import Foundation

// MARK: - Default Button Configurations

@objc public extension JJButtonAnimationConfiguration {

    @objc static func rotation(toAngle angle: CGFloat = -.pi / 4) -> JJButtonAnimationConfiguration {
        let configuration = JJButtonAnimationConfiguration(withStyle: .rotation)
        configuration.angle = angle
        return configuration
    }

    @objc static func transition(toImage image: UIImage) -> JJButtonAnimationConfiguration {
        let configuration = JJButtonAnimationConfiguration(withStyle: .transition)
        configuration.image = image
        return configuration
    }
}

@objc public class JJAnimationSettings: NSObject {

    @objc public var duration: TimeInterval = 0.3

    @objc public var dampingRatio: CGFloat = 0.55

    @objc public var velocity: CGFloat = 0.3

    @objc public var interItemDeleay: TimeInterval = 0.1
}

@objc public class JJButtonAnimationConfiguration: NSObject {

    @objc public init(withStyle style: JJButtonAnimationStyle) {
        self.style = style
    }

    @objc public enum JJButtonAnimationStyle: Int {
        case rotation
        case transition
    }

    @objc public let style: JJButtonAnimationStyle

    @objc public var angle: CGFloat = 0

    @objc public var image: UIImage?

    @objc public lazy var opening: JJAnimationSettings = {
        var settings = JJAnimationSettings()
        settings.duration = 0.3
        settings.dampingRatio = 0.55
        settings.velocity = 0.3
        return settings
    }()

    @objc public lazy var closing: JJAnimationSettings = {
        var settings = JJAnimationSettings()
        settings.duration = 0.3
        settings.dampingRatio = 0.6
        settings.velocity = 0.8
        return settings
    }()
}

@objc public extension JJItemAnimationConfiguration {

    @objc static func popUp(withInterItemSpacing interItemSpacing: CGFloat = 12) -> JJItemAnimationConfiguration {
        let configuration = JJItemAnimationConfiguration()
        configuration.itemLayout = .verticalLine(withInterItemSpacing: interItemSpacing)
        configuration.closedState = .scale()
        return configuration
    }

    @objc static func slideIn(withInterItemSpacing interItemSpacing: CGFloat = 12) -> JJItemAnimationConfiguration {
        let configuration = JJItemAnimationConfiguration()
        configuration.itemLayout = .verticalLine(withInterItemSpacing: interItemSpacing)
        configuration.closedState = .horizontalOffset()
        return configuration
    }

    @objc static func circularPopUp(withRadius radius: CGFloat = 100) -> JJItemAnimationConfiguration {
        let configuration = JJItemAnimationConfiguration()
        configuration.itemLayout = .circular(withRadius: radius)
        configuration.closedState = .scale()
        configuration.opening.interItemDeleay = 0.05
        configuration.closing.interItemDeleay = 0.05
        return configuration
    }

    @objc static func circularSlideIn(withRadius radius: CGFloat = 100) -> JJItemAnimationConfiguration {
        let configuration = JJItemAnimationConfiguration()
        configuration.itemLayout = .circular(withRadius: radius)
        configuration.closedState = .circularOffset(distance: radius * 0.75)
        return configuration
    }
}

@objc public class JJItemAnimationConfiguration: NSObject {

    @objc public lazy var opening: JJAnimationSettings = {
        var settings = JJAnimationSettings()
        settings.duration = 0.3
        settings.dampingRatio = 0.55
        settings.velocity = 0.3
        settings.interItemDeleay = 0.1
        return settings
    }()

    @objc public lazy var closing: JJAnimationSettings = {
        var settings = JJAnimationSettings()
        settings.duration = 0.15
        settings.dampingRatio = 0.6
        settings.velocity = 0.8
        settings.interItemDeleay = 0.1
        return settings
    }()

    @objc public var itemLayout: JJItemLayout = .verticalLine(withInterItemSpacing: 12)

    @objc public var openState: JJItemPreparation = .identity()

    @objc public var closedState: JJItemPreparation = .scale()
}

@objc public class JJItemLayout: NSObject {

    @objc public var layout: (_ items: [JJActionItem], _ referenceView: UIView) -> Void

    @objc public init(layout: @escaping (_ items: [JJActionItem], _ referenceView: UIView) -> Void) {
        self.layout = layout
    }

    @objc static func verticalLine(withInterItemSpacing interItemSpacing: CGFloat) -> JJItemLayout {
        return JJItemLayout { items, referenceView in
            var previousItem: JJActionItem?
            for item in items {
                let previousView = previousItem ?? referenceView
                item.bottomAnchor.constraint(equalTo: previousView.topAnchor, constant: -interItemSpacing).isActive = true
                item.circleView.centerXAnchor.constraint(equalTo: referenceView.centerXAnchor).isActive = true
                previousItem = item
            }
        }
    }

    @objc static func circular(withRadius radius: CGFloat) -> JJItemLayout {
        return JJItemLayout { items, referenceView in
            let numberOfItems = items.count
            var index: Int = 0
            for item in items {
                let angle = JJItemAnimationConfiguration.angleForItem(at: index, numberOfItems: numberOfItems, referenceView: referenceView)
                let dx = radius * cos(angle)
                let dy = radius * sin(angle)

                item.circleView.centerXAnchor.constraint(equalTo: referenceView.centerXAnchor, constant: dx).isActive = true
                item.circleView.centerYAnchor.constraint(equalTo: referenceView.centerYAnchor, constant: dy).isActive = true

                index += 1
            }
        }
    }
}

@objc public class JJItemPreparation: NSObject {

    @objc public var prepare: (_ item: JJActionItem, _ index: Int, _ numberOfItems: Int, _ referenceView: UIView) -> Void

    @objc public init(prepare: @escaping (_ item: JJActionItem, _ index: Int, _ numberOfItems: Int, _ referenceView: UIView) -> Void) {
        self.prepare = prepare
    }

    @objc static func identity() -> JJItemPreparation {
        return JJItemPreparation { item, _, _, _ in
            item.transform = .identity
            item.alpha = 1
        }
    }

    @objc static func scale(by ratio: CGFloat = 0.4) -> JJItemPreparation {
        return JJItemPreparation { item, _, _, _ in
            item.scale(by: ratio)
            item.alpha = 0
        }
    }

    @objc static func offset(translationX: CGFloat, translationY: CGFloat, scale: CGFloat = 0.4) -> JJItemPreparation {
        return JJItemPreparation { item, _, _, _ in
            item.scale(by: scale, translationX: translationX, translationY: translationY)
            item.alpha = 0
        }
    }

    @objc static func horizontalOffset(distance: CGFloat = 50, scale: CGFloat = 0.4) -> JJItemPreparation {
        return JJItemPreparation { item, _, _, referenceView in
            let translationX = referenceView.isOnLeftSideOfScreen ? -distance : distance
            item.scale(by: scale, translationX: translationX)
            item.alpha = 0
        }
    }

    @objc static func circularOffset(distance: CGFloat = 50, scale: CGFloat = 0.4) -> JJItemPreparation {
        return JJItemPreparation { item, index, numberOfItems, referenceView in
            let angle = JJItemAnimationConfiguration.angleForItem(at: index, numberOfItems: numberOfItems, referenceView: referenceView) + CGFloat.pi
            let translationX = distance * cos(angle)
            let translationY = distance * sin(angle)
            item.scale(by: scale, translationX: translationX, translationY: translationY)
            item.alpha = 0
        }
    }
}

internal extension JJItemAnimationConfiguration {

    static func angleForItem(at index: Int, numberOfItems: Int, referenceView: UIView) -> CGFloat {
        precondition(numberOfItems > 0)
        precondition(index >= 0)
        precondition(index < numberOfItems)

        let startAngle: CGFloat = referenceView.isOnLeftSideOfScreen ? 2 * .pi : .pi
        let endAngle: CGFloat = 1.5 * .pi

        var interItemAngle: CGFloat
        switch (numberOfItems, index) {
        case (1, _):
            return (startAngle + endAngle) / 2
        case (2, 0):
            return startAngle + 0.1 * (endAngle - startAngle)
        case (2, 1):
            return endAngle - 0.1 * (endAngle - startAngle)
        default:
            return startAngle + CGFloat(index) * (endAngle - startAngle) / (CGFloat(numberOfItems) - 1)
        }
    }
}

fileprivate extension JJActionItem {

    func scale(by factor: CGFloat, translationX: CGFloat = 0, translationY: CGFloat = 0) {
        let scale = scaleTransformation(factor: factor)
        let translation = CGAffineTransform(translationX: translationX, y: translationY)
        transform = scale.concatenating(translation)
    }
}

fileprivate extension JJActionItem {

    func scaleTransformation(factor: CGFloat) -> CGAffineTransform {
        let scale = CGAffineTransform(scaleX: factor, y: factor)

        let center = circleView.center
        let circleCenterScaled = point(center, transformed: scale)
        let translationX = center.x - circleCenterScaled.x
        let translationY = center.y - circleCenterScaled.y
        let translation = CGAffineTransform(translationX: translationX, y: translationY)
        return scale.concatenating(translation)
    }

    func point(_ point: CGPoint, transformed transform: CGAffineTransform) -> CGPoint {
        let anchorPoint = CGPoint(x: bounds.width * layer.anchorPoint.x, y: bounds.height * layer.anchorPoint.y)
        let relativePoint = CGPoint(x: point.x - anchorPoint.x, y: point.y - anchorPoint.y)
        let transformedPoint = relativePoint.applying(transform)
        let result = CGPoint(x: anchorPoint.x + transformedPoint.x, y: anchorPoint.y + transformedPoint.y)
        return result
    }
}

internal extension UIView {

    var isOnLeftSideOfScreen: Bool {
        return isOnLeftSide(ofView: UIApplication.shared.keyWindow)
    }

    func isOnLeftSide(ofView superview: UIView?) -> Bool {
        guard let superview = superview else {
            return false
        }
        let point = convert(center, to: superview)
        return point.x < superview.bounds.size.width / 2
    }
}
