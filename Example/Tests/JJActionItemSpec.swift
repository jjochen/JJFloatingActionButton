//
//  JJActionItemSpec.swift
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

class JJActionItemSpec: QuickSpec {
    override func spec() {
        describe("JJActionItem") {
            var actionItem: JJActionItem!

            beforeEach {
                actionItem = JJActionItem(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
                actionItem.titleLabel.font = UIFont(name: "Courier", size: 12)
                actionItem.titleLabel.text = "item"
                actionItem.imageView.image = #imageLiteral(resourceName: "Owl")
                actionItem.buttonColor = .red
                actionItem.buttonImageColor = .white

                actionItem.circleView.widthAnchor.constraint(equalToConstant: 40).isActive = true
                actionItem.circleView.heightAnchor.constraint(equalToConstant: 40).isActive = true

                setNimbleTolerance(0.002)
            }

            it("looks correct") {
                expect(actionItem) == snapshot()
            }

            it("looks correct with title position leading") {
                actionItem.titlePosition = .leading
                expect(actionItem) == snapshot()
            }

            it("looks correct with title position trailing") {
                actionItem.titlePosition = .trailing
                expect(actionItem) == snapshot()
            }

            it("looks correct with title position left") {
                actionItem.titlePosition = .left
                expect(actionItem) == snapshot()
            }

            it("looks correct with title position right") {
                actionItem.titlePosition = .right
                expect(actionItem) == snapshot()
            }

            it("looks correct with title position top") {
                actionItem.titlePosition = .top
                expect(actionItem) == snapshot()
            }

            it("looks correct with title position bottom") {
                actionItem.titlePosition = .bottom
                expect(actionItem) == snapshot()
            }

            it("looks correct with title position hidden") {
                actionItem.titlePosition = .hidden
                expect(actionItem) == snapshot()
            }

            it("looks correct with horizontal title spacing configured") {
                actionItem.titlePosition = .leading
                actionItem.titleSpacing = 42
                expect(actionItem) == snapshot()
            }

            it("looks correct with vertical title spacing configured") {
                actionItem.titlePosition = .bottom
                actionItem.titleSpacing = 42
                expect(actionItem) == snapshot()
            }

            it("looks correct with empty title") {
                actionItem.titleLabel.text = ""
                expect(actionItem) == snapshot()
            }

            it("looks correct with smaller image size") {
                actionItem.imageSize = CGSize(width: 10, height: 10)
                expect(actionItem) == snapshot()
            }

            it("looks correct with bigger image size") {
                actionItem.imageSize = CGSize(width: 30, height: 30)
                expect(actionItem) == snapshot()
            }
        }

        describe("JJActionItem loaded from xib") {
            var actionItem: JJActionItem?

            beforeEach {
                let bundle = Bundle(for: type(of: self))
                actionItem = bundle.loadNibNamed("JJActionItem", owner: nil)?.first as? JJActionItem

                actionItem?.titleLabel.font = UIFont(name: "Courier", size: 12)
                actionItem?.titleLabel.text = "item"
                actionItem?.imageView.image = #imageLiteral(resourceName: "Owl")
                actionItem?.buttonColor = .red
                actionItem?.buttonImageColor = .white

                actionItem?.circleView.widthAnchor.constraint(equalToConstant: 40).isActive = true
                actionItem?.circleView.heightAnchor.constraint(equalToConstant: 40).isActive = true

                setNimbleTolerance(0.002)
            }

            it("looks correct") {
                expect(actionItem) == snapshot()
            }
        }
    }
}
