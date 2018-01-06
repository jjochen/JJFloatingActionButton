//
//  JJFloatingActionButtonSpec.swift
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

class JJFloatingActionButtonSpec: QuickSpec {

    override func spec() {

        describe("JJFloatingActionButton") {

            let superviewFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 300))
            let actionButtonFrame = CGRect(origin: CGPoint(x: 130, y: 230), size: CGSize(width: 56, height: 56))

            var actionButton: JJFloatingActionButton!
            var superview: UIView!

            beforeEach {
                superview = UIView(frame: superviewFrame)
                superview.backgroundColor = .white

                actionButton = JJFloatingActionButton(frame: actionButtonFrame)
                superview.addSubview(actionButton)

                setNimbleTolerance(0.001)
            }

            it("does not open") {
                actionButton.open(animated: false)
                expect(actionButton.buttonState).to(equal(JJFloatingActionButtonState.closed))
            }

            it("does not open when tapped") {
                actionButton.sendActions(for: .touchUpInside)
                expect(actionButton.buttonState).toNotEventually(equal(JJFloatingActionButtonState.open))
            }

            it("looks correct by default") {
                expect(superview) == snapshot()
            }

            it("looks correct highlighted") {
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with dark color") {
                actionButton.buttonColor = UIColor(hue: 0.6, saturation: 0.9, brightness: 0.3, alpha: 1)
                actionButton.highlightedItemButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with light color") {
                actionButton.buttonColor = UIColor(hue: 0.4, saturation: 0.9, brightness: 0.7, alpha: 1)
                actionButton.highlightedItemButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with custom color") {
                actionButton.highlightedButtonColor = UIColor.orange
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview) == snapshot()
            }

            it("looks correct configured") {
                actionButton.buttonColor = UIColor.blue
                actionButton.highlightedButtonColor = UIColor.orange
                actionButton.defaultButtonImage = #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate)
                actionButton.openButtonImage = #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate)
                actionButton.buttonImageColor = UIColor.red
                actionButton.shadowColor = UIColor.orange
                actionButton.shadowOffset = CGSize(width: -5, height: -5)
                actionButton.shadowOpacity = Float(0.6)
                actionButton.shadowRadius = CGFloat(0)
                actionButton.overlayView.backgroundColor = UIColor.brown.withAlphaComponent(0.3)
                actionButton.itemTitleFont = UIFont.boldSystemFont(ofSize: 5)
                actionButton.itemButtonColor = UIColor.magenta
                actionButton.highlightedItemButtonColor = UIColor.red
                actionButton.itemImageColor = UIColor.cyan
                actionButton.itemTitleColor = UIColor.blue
                actionButton.itemShadowColor = UIColor.yellow
                actionButton.itemShadowOffset = CGSize(width: 2, height: 0)
                actionButton.itemShadowOpacity = Float(1)
                actionButton.itemShadowRadius = CGFloat(0)
                actionButton.itemSizeRatio = CGFloat(1.1)
                actionButton.interItemSpacing = CGFloat(7)
                actionButton.rotationAngle = -CGFloat.pi / 5

                actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate))

                actionButton.open(animated: false)

                expect(superview) == snapshot()
            }

            it("looks correct configured after adding the items") {
                actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate))

                actionButton.buttonColor = UIColor.blue
                actionButton.defaultButtonImage = #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate)
                actionButton.buttonImageColor = UIColor.red
                actionButton.shadowColor = UIColor.orange
                actionButton.shadowOffset = CGSize(width: -5, height: -5)
                actionButton.shadowOpacity = Float(0.6)
                actionButton.shadowRadius = CGFloat(0)
                actionButton.overlayView.backgroundColor = UIColor.brown.withAlphaComponent(0.3)
                actionButton.itemTitleFont = UIFont.boldSystemFont(ofSize: 5)
                actionButton.itemButtonColor = UIColor.magenta
                actionButton.itemImageColor = UIColor.cyan
                actionButton.itemTitleColor = UIColor.blue
                actionButton.itemShadowColor = UIColor.yellow
                actionButton.itemShadowOffset = CGSize(width: 2, height: 0)
                actionButton.itemShadowOpacity = Float(1)
                actionButton.itemShadowRadius = CGFloat(0)
                actionButton.itemSizeRatio = CGFloat(1.1)
                actionButton.interItemSpacing = CGFloat(7)
                actionButton.rotationAngle = -CGFloat.pi / 5

                actionButton.open(animated: false)

                expect(superview) == snapshot()
            }

            context("when multiple items are added") {
                var action = "not done"
                beforeEach {
                    actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate)) { _ in
                        action = "done!"
                    }
                    actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate))
                }

                it("opens when tapped") {
                    actionButton.sendActions(for: .touchUpInside)
                    expect(actionButton.buttonState).toEventually(equal(JJFloatingActionButtonState.open))
                }

                it("opens when tapped twice") {
                    actionButton.sendActions(for: .touchUpInside)
                    actionButton.sendActions(for: .touchUpInside)
                    expect(actionButton.buttonState).toEventually(equal(JJFloatingActionButtonState.opening))
                    expect(actionButton.buttonState).toEventually(equal(JJFloatingActionButtonState.open))
                }

                context("and is opened") {
                    beforeEach {
                        actionButton.open(animated: false)
                    }

                    it("has state open") {
                        expect(actionButton.buttonState) == JJFloatingActionButtonState.open
                    }

                    it("items look correct") {
                        expect(superview) == snapshot()
                    }

                    it("items look correct highlighted") {
                        let item = actionButton.items[0]
                        item.isHighlighted = true
                        expect(item.isHighlighted).to(beTrue())
                        expect(superview) == snapshot()
                    }

                    it("items look correct highlighted with custom highligted color") {
                        actionButton.highlightedItemButtonColor = UIColor.purple
                        let item = actionButton.items[0]
                        item.isHighlighted = true
                        expect(item.isHighlighted).to(beTrue())
                        expect(superview) == snapshot()
                    }

                    it("can't be opened again") {
                        actionButton.open(animated: true)
                        expect(actionButton.buttonState) != JJFloatingActionButtonState.opening
                    }

                    context("and overlay is tapped") {
                        beforeEach {
                            actionButton.overlayView.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState).toNotEventually(equal(JJFloatingActionButtonState.closed))
                        }
                    }

                    context("and button is tapped") {
                        beforeEach {
                            actionButton.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState).toNotEventually(equal(JJFloatingActionButtonState.closed))
                        }

                        it("does not perform action") {
                            expect(action).toNotEventually(equal("done!"))
                        }
                    }

                    context("and item is tapped") {
                        beforeEach {
                            let item = actionButton.items[0]
                            item.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState).toNotEventually(equal(JJFloatingActionButtonState.closed))
                        }

                        it("performs action") {
                            expect(action).toEventually(equal("done!"))
                        }
                    }
                }

                context("and is opened and closed") {
                    beforeEach {
                        actionButton.open(animated: false)
                        actionButton.close(animated: false)
                    }

                    it("looks correct") {
                        expect(superview) == snapshot()
                    }

                    it("can't be closed again") {
                        actionButton.close(animated: true)
                        expect(actionButton.buttonState) != JJFloatingActionButtonState.closing
                    }
                }

                context("and is opened animated") {
                    beforeEach {
                        actionButton.open(animated: true)
                    }

                    it("has state opening") {
                        expect(actionButton.buttonState) == JJFloatingActionButtonState.opening
                    }

                    it("has eventually state open") {
                        expect(actionButton.buttonState).toEventually(equal(JJFloatingActionButtonState.open))
                    }
                }

                context("and is closed animated") {
                    beforeEach {
                        actionButton.open(animated: false)
                        actionButton.close(animated: true)
                    }

                    it("has state closing") {
                        expect(actionButton.buttonState) == JJFloatingActionButtonState.closing
                    }

                    it("has eventually state closed") {
                        expect(actionButton.buttonState).toEventually(equal(JJFloatingActionButtonState.closed))
                    }
                }

                context("and is opened animated with open image") {
                    beforeEach {
                        actionButton.openButtonImage = #imageLiteral(resourceName: "Dots")
                        actionButton.open(animated: true)
                    }

                    it("eventually shows open image") {
                        expect(actionButton.imageView.image).toEventually(equal(actionButton.openButtonImage))
                    }
                }

                context("and is closed animated with open image") {
                    beforeEach {
                        actionButton.openButtonImage = #imageLiteral(resourceName: "Dots")
                        actionButton.open(animated: false)
                        actionButton.close(animated: true)
                    }

                    it("eventually shows default image") {
                        expect(actionButton.imageView.image).toEventually(equal(actionButton.defaultButtonImage))
                    }
                }

                context("plus one hidden item") {
                    var hiddenItem: JJActionItem!
                    beforeEach {
                        hiddenItem = actionButton.addItem(title: "hidden item", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                        hiddenItem.isHidden = true
                    }

                    it("it will not be added") {
                        expect(actionButton.enabledItems).toNot(contain(hiddenItem))
                    }

                    it("looks correct when opened") {
                        actionButton.open(animated: false)
                        expect(superview) == snapshot()
                    }
                }
            }

            context("when 1 item is added") {
                var action = "not done"
                beforeEach {
                    actionButton.addItem(title: "item", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate)) { _ in
                        action = "done!"
                    }
                }

                it("looks correct") {
                    expect(superview) == snapshot()
                }

                context("and button is tapped") {
                    beforeEach {
                        actionButton.sendActions(for: .touchUpInside)
                    }

                    it("does not open") {
                        expect(actionButton.buttonState).toNotEventually(equal(JJFloatingActionButtonState.open))
                    }

                    it("performs action") {
                        expect(action).toEventually(equal("done!"))
                    }
                }

                context("and is opened") {
                    beforeEach {
                        actionButton.open(animated: false)
                    }

                    it("has state closed") {
                        expect(actionButton.buttonState) == JJFloatingActionButtonState.closed
                    }

                    it("looks correct") {
                        expect(superview) == snapshot()
                    }
                }

                context("and is opened with handle single action direclty disabled") {
                    beforeEach {
                        actionButton.handleSingleActionDirectly = false
                        actionButton.open(animated: false)
                    }

                    it("opens") {
                        expect(actionButton.buttonState) == JJFloatingActionButtonState.open
                    }

                    it("looks correct") {
                        expect(superview) == snapshot()
                    }
                }
            }
        }

        describe("JJFloatingActionButton with rtl language") {
            let superviewFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 300))
            let actionButtonFrame = CGRect(origin: CGPoint(x: 20, y: 230), size: CGSize(width: 56, height: 56))

            var actionButton: JJFloatingActionButton!
            var superview: UIView!

            beforeEach {
                superview = UIView(frame: superviewFrame)
                superview.backgroundColor = .white

                actionButton = JJFloatingActionButton(frame: actionButtonFrame)
                superview.addSubview(actionButton)

                superview.semanticContentAttribute = .forceRightToLeft
                actionButton.semanticContentAttribute = .forceRightToLeft

                setNimbleTolerance(0.004)
            }

            it("looks correct") {
                let item1 = actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                item1.semanticContentAttribute = .forceRightToLeft
                let item2 = actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate))
                item2.semanticContentAttribute = .forceRightToLeft

                actionButton.open(animated: false)

                expect(superview) == snapshot()
            }
        }

        describe("JJFloatingActionButton without superview") {

            let actionButtonFrame = CGRect(origin: .zero, size: CGSize(width: 56, height: 56))
            var actionButton: JJFloatingActionButton!

            beforeEach {
                actionButton = JJFloatingActionButton(frame: actionButtonFrame)
            }

            context("when multiple items are added") {

                beforeEach {
                    actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                    actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate))
                }

                it("does not open when tapped") {
                    actionButton.sendActions(for: .touchUpInside)
                    expect(actionButton.buttonState).toNotEventually(equal(JJFloatingActionButtonState.open))
                }
            }
        }

        describe("JJFloatingActionButton loaded from xib") {
            var actionButton: JJFloatingActionButton?

            beforeEach {
                let bundle = Bundle(for: type(of: self))
                actionButton = bundle.loadNibNamed("JJFloatingActionButton", owner: nil)?.first as? JJFloatingActionButton
            }

            it("looks correct") {
                expect(actionButton) == snapshot()
            }
        }

        describe("JJFloatingActionButton with a delegate") {

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
