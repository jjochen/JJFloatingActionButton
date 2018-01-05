//
//  JJFloatingActionButton+Placement.swift
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

    func add(to superview: UIView, viewInset: CGFloat = 16, safeAreaInset: CGFloat = 0) {
        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        var trailing: NSLayoutConstraint

        trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -viewInset)
        trailing.priority = UILayoutPriority(250)
        trailing.isActive = true

        trailing = trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: -viewInset)
        trailing.priority = .required
        trailing.isActive = true

        if #available(iOS 11.0, *) {
            trailing = trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -safeAreaInset)
            trailing.priority = UILayoutPriority(750)
            trailing.isActive = true

            trailing = trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -safeAreaInset)
            trailing.priority = .required
            trailing.isActive = true
        }

        var bottom: NSLayoutConstraint

        bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -viewInset)
        bottom.priority = UILayoutPriority(250)
        bottom.isActive = true

        bottom = bottomAnchor.constraint(lessThanOrEqualTo: superview.bottomAnchor, constant: -viewInset)
        bottom.priority = .required
        bottom.isActive = true

        if #available(iOS 11.0, *) {
            bottom = bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaInset)
            bottom.priority = UILayoutPriority(750)
            bottom.isActive = true

            bottom = bottomAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaInset)
            bottom.priority = .required
            bottom.isActive = true
        }
    }

    func add(to viewController: UIViewController, viewInset: CGFloat = 16, safeAreaInset: CGFloat =
        0) {
        if let superview = viewController.view {
            add(to: superview, viewInset: viewInset, safeAreaInset: safeAreaInset)

            var bottom: NSLayoutConstraint

            bottom = bottomAnchor.constraint(equalTo: viewController.bottomLayoutGuide.topAnchor, constant: -viewInset)
            bottom.priority = UILayoutPriority(500)
            bottom.isActive = true

            bottom = bottomAnchor.constraint(lessThanOrEqualTo: viewController.bottomLayoutGuide.topAnchor, constant: -viewInset)
            bottom.priority = .required
            bottom.isActive = true
        }
    }
}
