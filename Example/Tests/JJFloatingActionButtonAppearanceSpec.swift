//
//  JJFloatingActionButtonAppearanceSpec.swift
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

class JJFloatingActionButtonAppearanceSpec: QuickSpec {
    override func spec() {
        describe("JJFloatingActionButton") {
            var actionButton: JJFloatingActionButton!

            beforeEach {
                actionButton = JJFloatingActionButton()
            }

            it("stores button color correctly") {
                let value1 = UIColor.red
                actionButton.buttonColor = value1
                expect(actionButton.buttonColor) == value1
                expect(actionButton.circleView.color) == value1

                let value2 = UIColor.blue
                actionButton.circleView.color = value2
                expect(actionButton.buttonColor) == value2
                expect(actionButton.circleView.color) == value2
            }

            it("stores highlighted button color correctly") {
                let value1 = UIColor.red
                actionButton.highlightedButtonColor = value1
                expect(actionButton.highlightedButtonColor) == value1
                expect(actionButton.circleView.highlightedColor) == value1

                let value2 = UIColor.blue
                actionButton.circleView.highlightedColor = value2
                expect(actionButton.highlightedButtonColor) == value2
                expect(actionButton.circleView.highlightedColor) == value2
            }

            it("stores button image color correctly") {
                let value1 = UIColor.red
                actionButton.buttonImageColor = value1
                expect(actionButton.buttonImageColor) == value1
                expect(actionButton.imageView.tintColor) == value1

                let value2 = UIColor.blue
                actionButton.imageView.tintColor = value2
                expect(actionButton.buttonImageColor) == value2
                expect(actionButton.imageView.tintColor) == value2
            }

            it("stores shadow color correctly") {
                let value1 = UIColor.red
                actionButton.shadowColor = value1
                expect(actionButton.shadowColor) == value1
                expect(UIColor(cgColor: actionButton.layer.shadowColor!)) == value1

                let value2 = UIColor.blue
                actionButton.layer.shadowColor = value2.cgColor
                expect(actionButton.shadowColor) == value2
                expect(UIColor(cgColor: actionButton.layer.shadowColor!)) == value2

                actionButton.shadowColor = nil
                expect(actionButton.shadowColor).to(beNil())
            }

            it("stores shadow offset correctly") {
                let value1 = CGSize(width: 2, height: 4)
                actionButton.shadowOffset = value1
                expect(actionButton.shadowOffset) == value1
                expect(actionButton.layer.shadowOffset) == value1

                let value2 = CGSize(width: 3, height: 2)
                actionButton.layer.shadowOffset = value2
                expect(actionButton.shadowOffset) == value2
                expect(actionButton.layer.shadowOffset) == value2
            }

            it("stores shadow opacity correctly") {
                let value1 = Float(0.8)
                actionButton.shadowOpacity = value1
                expect(actionButton.shadowOpacity) == value1
                expect(actionButton.layer.shadowOpacity) == value1

                let value2 = Float(0.5)
                actionButton.layer.shadowOpacity = value2
                expect(actionButton.shadowOpacity) == value2
                expect(actionButton.layer.shadowOpacity) == value2
            }

            it("stores shadow radius correctly") {
                let value1 = CGFloat(8)
                actionButton.shadowRadius = value1
                expect(actionButton.shadowRadius) == value1
                expect(actionButton.layer.shadowRadius) == value1

                let value2 = CGFloat(5)
                actionButton.layer.shadowRadius = value2
                expect(actionButton.shadowRadius) == value2
                expect(actionButton.layer.shadowRadius) == value2
            }
        }
    }
}
