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

@objc public class JJAnimationSettings: NSObject {

    @objc public var duration: TimeInterval = 0.3

    @objc public var dampingRatio: CGFloat = 0.55

    @objc public var velocity: CGFloat = 0.3
}

@objc public class JJButtonAnimationConfiguration: NSObject {

    @objc public static func rotation(toAngle angle: CGFloat = -.pi / 4) -> JJButtonAnimationConfiguration {
        return JJButtonAnimationConfiguration(rotationToAngle: angle)
    }

    @objc public static func transition(toImage image: UIImage) -> JJButtonAnimationConfiguration {
        return JJButtonAnimationConfiguration(transitionToImage: image)
    }

    @objc public init(transitionToImage image: UIImage) {
        style = .transition
        self.image = image
    }

    @objc public init(rotationToAngle angle: CGFloat) {
        style = .rotation
        self.angle = angle
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
