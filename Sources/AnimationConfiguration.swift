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
        let configuration = JJItemAnimationConfiguration(withLayout: .vertical)
        configuration.interItemSpacing = interItemSpacing
        configuration.slideDistance = 0
        return configuration
    }

    @objc static func slideIn(withInterItemSpacing interItemSpacing: CGFloat = 12) -> JJItemAnimationConfiguration {
        let configuration = JJItemAnimationConfiguration(withLayout: .vertical)
        configuration.interItemSpacing = interItemSpacing
        configuration.slideDistance = 50
        return configuration
    }

    @objc static func circularPopUp(withRadius radius: CGFloat = 100) -> JJItemAnimationConfiguration {
        let configuration = JJItemAnimationConfiguration(withLayout: .circular)
        configuration.radius = radius
        configuration.slideDistance = 0
        return configuration
    }

    @objc static func circularSlideIn(withRadius radius: CGFloat = 100) -> JJItemAnimationConfiguration {
        let configuration = JJItemAnimationConfiguration(withLayout: .circular)
        configuration.radius = radius
        configuration.slideDistance = radius * 0.75
        return configuration
    }
}

@objc public class JJItemAnimationConfiguration: NSObject {

    @objc public init(withLayout layout: JJItemLayout) {
        self.layout = layout
    }

    @objc public enum JJItemLayout: Int {
        case vertical
        case circular
    }

    @objc public let layout: JJItemLayout

    @objc public var interItemDelayWhenOpening: TimeInterval = 0.1

    @objc public var interItemDelayWhenClosing: TimeInterval = 0.1

    @objc public var interItemSpacing: CGFloat = 12

    @objc public var radius: CGFloat = 100

    @objc public var slideDistance: CGFloat = 0

    @objc public lazy var opening: JJAnimationSettings = {
        var settings = JJAnimationSettings()
        settings.duration = 0.3
        settings.dampingRatio = 0.55
        settings.velocity = 0.3
        return settings
    }()

    @objc public lazy var closing: JJAnimationSettings = {
        var settings = JJAnimationSettings()
        settings.duration = 0.15
        settings.dampingRatio = 0.6
        settings.velocity = 0.8
        return settings
    }()
}

internal extension JJItemAnimationConfiguration {

    func prepareItemForClosedState(_ item: JJActionItem, atIndex index: Int, numberOfItems: Int) {

        let angle = slideAngleForItem(item, at: index, numberOfItems: numberOfItems)
        let dx = slideDistance * cos(angle)
        let dy = slideDistance * sin(angle)
        let point = item.circleView.center.applying(CGAffineTransform(translationX: dx, y: dy))
        item.scale(by: 0.4, translateCircleCenterTo: point)

        item.alpha = 0
    }

    func prepareItemForOpenState(_ item: JJActionItem) {
        item.transform = .identity
        item.alpha = 1
    }

    func layoutItems(_ items: [JJActionItem], referenceView: UIView) {
        switch layout {
        case .vertical:
            layoutItemsInVerticalLine(items, referenceView: referenceView)
        case .circular:
            layoutItemsInCircle(items, referenceView: referenceView)
        }
    }
}

fileprivate extension JJItemAnimationConfiguration {

    func layoutItemsInVerticalLine(_ items: [JJActionItem], referenceView: UIView) {
        var previousItem: JJActionItem?
        for item in items {
            let previousView = previousItem ?? referenceView
            item.bottomAnchor.constraint(equalTo: previousView.topAnchor, constant: -interItemSpacing).isActive = true
            item.circleView.centerXAnchor.constraint(equalTo: referenceView.centerXAnchor).isActive = true
            previousItem = item
        }
    }

    func layoutItemsInCircle(_ items: [JJActionItem], referenceView: UIView) {
        let numberOfItems = items.count
        var index: Int = 0
        for item in items {
            let angle = angleForItem(at: index, numberOfItems: numberOfItems)
            let dx = radius * cos(angle)
            let dy = radius * sin(angle)

            item.circleView.centerXAnchor.constraint(equalTo: referenceView.centerXAnchor, constant: dx).isActive = true
            item.circleView.centerYAnchor.constraint(equalTo: referenceView.centerYAnchor, constant: dy).isActive = true

            index += 1
        }
    }

    func slideAngleForItem(_ item: JJActionItem, at index: Int, numberOfItems: Int) -> CGFloat {
        switch layout {
        case .vertical:
            return item.isTitleOnTheRight ? CGFloat.pi : 0
        case .circular:
            return angleForItem(at: index, numberOfItems: numberOfItems) + CGFloat.pi
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
