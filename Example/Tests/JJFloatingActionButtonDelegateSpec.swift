//
//  JJFloatingActionButtonDelegateSpec.swift
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

@testable import JJFloatingActionButton
import Nimble
import Nimble_Snapshots
import Quick

class JJFloatingActionButtonDelegateSpec: QuickSpec {
    override func spec() {
        describe("JJFloatingActionButton") {
            var superview: UIView!
            var actionButton: JJFloatingActionButton!
            var delegate: JJFloatingActionButtonDelegateMock!

            beforeEach {
                superview = UIView()
                actionButton = JJFloatingActionButton()
                actionButton.addItem(title: "item 1")
                actionButton.addItem(title: "item 2")
                superview.addSubview(actionButton)

                delegate = JJFloatingActionButtonDelegateMock()
                actionButton.delegate = delegate
            }

            it("calls delegate when opening animated") {
                expect(delegate.willOpenCalled).to(beFalse())
                expect(delegate.didOpenCalled).to(beFalse())

                actionButton.open(animated: true)

                expect(delegate.willOpenCalled).to(beTrue())
                expect(delegate.didOpenCalled).to(beFalse())
                expect(delegate.didOpenCalled).toEventually(beTrue())
            }

            it("calls delegate when closing animated") {
                actionButton.open(animated: false)

                expect(delegate.willCloseCalled).to(beFalse())
                expect(delegate.didCloseCalled).to(beFalse())

                actionButton.close(animated: true)

                expect(delegate.willCloseCalled).to(beTrue())
                expect(delegate.didCloseCalled).to(beFalse())
                expect(delegate.didCloseCalled).toEventually(beTrue())
            }

            it("calls delegate when opening and closing without animation") {
                expect(delegate.willOpenCalled).to(beFalse())
                expect(delegate.didOpenCalled).to(beFalse())
                expect(delegate.willCloseCalled).to(beFalse())
                expect(delegate.didCloseCalled).to(beFalse())

                actionButton.open(animated: false)

                expect(delegate.willOpenCalled).to(beTrue())
                expect(delegate.didOpenCalled).to(beTrue())
                expect(delegate.willCloseCalled).to(beFalse())
                expect(delegate.didCloseCalled).to(beFalse())

                actionButton.close(animated: false)

                expect(delegate.willOpenCalled).to(beTrue())
                expect(delegate.didOpenCalled).to(beTrue())
                expect(delegate.willCloseCalled).to(beTrue())
                expect(delegate.didCloseCalled).to(beTrue())
            }
        }
    }
}
