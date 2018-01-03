//
//  JJActionItem.swift
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

/// The item view representing an action.
///
@objc @IBDesignable open class JJActionItem: UIControl {

    /// The action that is executen when the item is pressed. Default is `nil`.
    ///
    @objc open var action: ((JJActionItem) -> Void)?

    /// The title label of the item. Can be configured as needed.
    /// Read only.
    ///
    @objc open fileprivate(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.isUserInteractionEnabled = false
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    /// The image view of the item. Can be configured as needed.
    /// Read only.
    ///
    @objc open fileprivate(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    /// The background circle of the item. Can be configured as needed.
    /// Read only.
    ///
    @objc open fileprivate(set) lazy var circleView: JJCircleView = {
        let view = JJCircleView()
        view.isUserInteractionEnabled = false
        return view
    }()

    internal override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    /// Returns an object initialized from data in a given unarchiver.
    ///
    /// - Parameter aDecoder: An unarchiver object.
    ///
    /// - Returns: `self`, initialized using the data in decoder.
    ///
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: - UIView

extension JJActionItem {

    /// Tells the view that its superview changed.
    ///
    open override func didMoveToSuperview() {
        // reset tintAdjustmentMode
        imageView.tintColorDidChange()
    }
}

// MARK: - UIControl

extension JJActionItem {

    /// A Boolean value indicating whether the action item draws a highlight.
    ///
    open override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            circleView.isHighlighted = newValue
        }
        get {
            return super.isHighlighted
        }
    }
}

// MARK: - Private Methods

fileprivate extension JJActionItem {

    func setup() {
        backgroundColor = .clear
        isUserInteractionEnabled = true

        addSubview(titleLabel)
        addSubview(circleView)
        addSubview(imageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        circleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        circleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor).isActive = true
        circleView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12).isActive = true

        let imageSizeMuliplier = CGFloat(1 / sqrt(2))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: circleView.widthAnchor, multiplier: imageSizeMuliplier).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualTo: circleView.heightAnchor, multiplier: imageSizeMuliplier).isActive = true
    }
}
