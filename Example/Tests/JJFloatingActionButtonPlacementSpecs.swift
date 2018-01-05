//
//  JJFloatingActionButtonPlacementSpecs.swift
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
@testable import JJFloatingActionButton
import Nimble
import Nimble_Snapshots
import Quick

class JJFloatingActionButtonPlacementSpec: QuickSpec {

    override func spec() {
        if #available(iOS 11.0, *) {
            context("iOS 11") {
                osAgnosticSpec()
            }
        } else {
            context("iOS 10") {
                osAgnosticSpec()
            }
        }
    }

    func osAgnosticSpec() {

        describe("JJFloatingActionButton") {

            let windowFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 300))

            var actionButton: JJFloatingActionButton!
            var viewController: UIViewController!

            beforeEach {
                viewController = UIViewController()

                let window = UIWindow(frame: windowFrame)
                window.rootViewController = viewController
                window.makeKeyAndVisible()

                viewController.view.backgroundColor = .white

                actionButton = JJFloatingActionButton()

                setNimbleTolerance(0.004)
            }

            it("looks correct when placed in view controller") {
                actionButton.add(to: viewController)
                expect(viewController.view) == snapshot()
            }
        }
    }
}
