//
// JJFloatingActionButton+Placement.swift
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

    func display(in superview: UIView) {

        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        let offset = CGFloat(16)
        if #available(iOS 11.0, *) {
            let trailing = trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -offset)
            let bottom = bottomAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
            NSLayoutConstraint.activate([trailing, bottom])
        } else {
            let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -offset)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offset)
            NSLayoutConstraint.activate([trailing, bottom])
        }
    }

    func display(in controller: UIViewController) {

        guard let superview = controller.view else {
            return
        }

        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        let offset = CGFloat(16)
        if #available(iOS 11.0, *) {
            let trailing = trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -offset)
            let bottom = bottomAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -offset)
            NSLayoutConstraint.activate([trailing, bottom])
        } else {
            let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -offset)
            let bottom = bottomAnchor.constraint(equalTo: controller.bottomLayoutGuide.topAnchor, constant: -offset)
            NSLayoutConstraint.activate([trailing, bottom])
        }
    }
}
