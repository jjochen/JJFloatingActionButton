//
//  JJActionItemAppearanceSpec.swift
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

class JJActionItemAppearanceSpec: QuickSpec {
    override func spec() {
        describe("JJActionItem") {
            var item: JJActionItem!

            beforeEach {
                item = JJActionItem()
            }

            it("stores button image correctly") {
                let value1 = #imageLiteral(resourceName: "Owl")
                item.buttonImage = value1
                expect(item.buttonImage) == value1
                expect(item.imageView.image) == value1

                let value2 = #imageLiteral(resourceName: "Like")
                item.imageView.image = value2
                expect(item.buttonImage) == value2
                expect(item.imageView.image) == value2
            }

            it("stores button color correctly") {
                let value1 = UIColor.red
                item.buttonColor = value1
                expect(item.buttonColor) == value1
                expect(item.circleView.color) == value1

                let value2 = UIColor.blue
                item.circleView.color = value2
                expect(item.buttonColor) == value2
                expect(item.circleView.color) == value2
            }

            it("stores highlighted button color correctly") {
                let value1 = UIColor.red
                item.highlightedButtonColor = value1
                expect(item.highlightedButtonColor) == value1
                expect(item.circleView.highlightedColor) == value1

                let value2 = UIColor.blue
                item.circleView.highlightedColor = value2
                expect(item.highlightedButtonColor) == value2
                expect(item.circleView.highlightedColor) == value2
            }

            it("stores button image color correctly") {
                let value1 = UIColor.red
                item.buttonImageColor = value1
                expect(item.buttonImageColor) == value1
                expect(item.imageView.tintColor) == value1

                let value2 = UIColor.blue
                item.imageView.tintColor = value2
                expect(item.buttonImageColor) == value2
                expect(item.imageView.tintColor) == value2
            }

            it("stores shadow color correctly") {
                let value1 = UIColor.red
                item.shadowColor = value1
                expect(item.shadowColor) == value1
                expect(UIColor(cgColor: item.layer.shadowColor!)) == value1

                let value2 = UIColor.blue
                item.layer.shadowColor = value2.cgColor
                expect(item.shadowColor) == value2
                expect(UIColor(cgColor: item.layer.shadowColor!)) == value2

                item.shadowColor = nil
                expect(item.shadowColor).to(beNil())
            }

            it("stores shadow offset correctly") {
                let value1 = CGSize(width: 2, height: 4)
                item.shadowOffset = value1
                expect(item.shadowOffset) == value1
                expect(item.layer.shadowOffset) == value1

                let value2 = CGSize(width: 3, height: 2)
                item.layer.shadowOffset = value2
                expect(item.shadowOffset) == value2
                expect(item.layer.shadowOffset) == value2
            }

            it("stores shadow opacity correctly") {
                let value1 = Float(0.8)
                item.shadowOpacity = value1
                expect(item.shadowOpacity) == value1
                expect(item.layer.shadowOpacity) == value1

                let value2 = Float(0.5)
                item.layer.shadowOpacity = value2
                expect(item.shadowOpacity) == value2
                expect(item.layer.shadowOpacity) == value2
            }

            it("stores shadow radius correctly") {
                let value1 = CGFloat(8)
                item.shadowRadius = value1
                expect(item.shadowRadius) == value1
                expect(item.layer.shadowRadius) == value1

                let value2 = CGFloat(5)
                item.layer.shadowRadius = value2
                expect(item.shadowRadius) == value2
                expect(item.layer.shadowRadius) == value2
            }
        }
    }
}
