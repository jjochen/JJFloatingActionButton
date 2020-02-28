//
//  UIColorExtensionsSpec.swift
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
import Quick

class UIColorExtensionsSpec: QuickSpec {
    override func spec() {
        describe("UIColor") {
            context("when light") {
                var originalColor: UIColor!
                var highlightedColor: UIColor!

                beforeEach {
                    originalColor = UIColor(hue: 0.63, saturation: 0.64, brightness: 0.70, alpha: 1.00)
                    highlightedColor = originalColor.highlighted
                }

                it("has a lower brightness in highlighted version") {
                    var originalBrightness = CGFloat(0)
                    originalColor.getHue(nil, saturation: nil, brightness: &originalBrightness, alpha: nil)

                    var highlightedBrightness = CGFloat(0)
                    highlightedColor.getHue(nil, saturation: nil, brightness: &highlightedBrightness, alpha: nil)

                    expect(highlightedBrightness).to(beLessThan(originalBrightness))
                }
            }

            context("when dark") {
                var originalColor: UIColor!
                var highlightedColor: UIColor!

                beforeEach {
                    originalColor = UIColor(hue: 0.63, saturation: 0.64, brightness: 0.30, alpha: 1.00)
                    highlightedColor = originalColor.highlighted
                }

                it("has a greater brightness in highlighted version") {
                    var originalBrightness = CGFloat(0)
                    originalColor.getHue(nil, saturation: nil, brightness: &originalBrightness, alpha: nil)

                    var highlightedBrightness = CGFloat(0)
                    highlightedColor.getHue(nil, saturation: nil, brightness: &highlightedBrightness, alpha: nil)

                    expect(highlightedBrightness).to(beGreaterThan(originalBrightness))
                }
            }
        }
    }
}
