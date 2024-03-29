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
import XCTest

class JJFloatingActionButtonSpec: QuickSpec {
    override class func spec() {
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

                setNimbleTolerance(0.01)
                setNimblePixelTolerance(0.01)
            }

            it("does not open") {
                actionButton.open(animated: false)
                expect(actionButton.buttonState) == .closed
            }

            it("does not open when tapped") {
                actionButton.sendActions(for: .touchUpInside)
                expect(actionButton.buttonState) == .closed
            }

            it("looks correct by default") {
                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct highlighted") {
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct highlighted with dark color") {
                actionButton.buttonColor = UIColor(hue: 0.6, saturation: 0.9, brightness: 0.3, alpha: 1)
                actionButton.highlightedButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct highlighted with light color") {
                actionButton.buttonColor = UIColor(hue: 0.4, saturation: 0.9, brightness: 0.7, alpha: 1)
                actionButton.highlightedButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct highlighted with custom color") {
                actionButton.highlightedButtonColor = .orange
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct configured") {
                actionButton.buttonColor = .blue
                actionButton.highlightedButtonColor = .orange
                actionButton.buttonImage = #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate)
                actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "Balloon"))
                actionButton.buttonImageColor = .red
                actionButton.shadowColor = .orange
                actionButton.shadowOffset = CGSize(width: -5, height: -5)
                actionButton.shadowOpacity = Float(0.6)
                actionButton.shadowRadius = CGFloat(0)
                actionButton.overlayView.backgroundColor = UIColor.brown.withAlphaComponent(0.3)
                actionButton.configureDefaultItem { item in
                    item.titleLabel.font = .boldSystemFont(ofSize: 5)
                    item.titleLabel.textColor = .blue
                    item.buttonColor = .magenta
                    item.highlightedButtonColor = .red
                    item.buttonImageColor = .cyan
                    item.shadowColor = .yellow
                    item.shadowOffset = CGSize(width: 2, height: 0)
                    item.shadowOpacity = Float(1)
                    item.shadowRadius = CGFloat(0)
                }
                actionButton.itemSizeRatio = CGFloat(1.1)
                actionButton.itemAnimationConfiguration = .popUp(withInterItemSpacing: 7)

                actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Balloon").withRenderingMode(.alwaysTemplate))

                actionButton.open(animated: false)

                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct configured after adding the items") {
                actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Balloon").withRenderingMode(.alwaysTemplate))

                actionButton.buttonColor = .blue
                actionButton.buttonImage = #imageLiteral(resourceName: "Balloon").withRenderingMode(.alwaysTemplate)
                actionButton.buttonAnimationConfiguration = .rotation(toAngle: -CGFloat.pi / 5)
                actionButton.buttonImageColor = .red
                actionButton.shadowColor = .orange
                actionButton.shadowOffset = CGSize(width: -5, height: -5)
                actionButton.shadowOpacity = Float(0.6)
                actionButton.shadowRadius = CGFloat(0)
                actionButton.overlayView.backgroundColor = UIColor.brown.withAlphaComponent(0.3)
                actionButton.configureDefaultItem { item in
                    item.titleLabel.font = .boldSystemFont(ofSize: 5)
                    item.titleLabel.textColor = .blue
                    item.buttonColor = .magenta
                    item.highlightedButtonColor = .red
                    item.buttonImageColor = .cyan
                    item.shadowColor = .yellow
                    item.shadowOffset = CGSize(width: 2, height: 0)
                    item.shadowOpacity = Float(1)
                    item.shadowRadius = CGFloat(0)
                }
                actionButton.itemSizeRatio = CGFloat(1.1)
                actionButton.itemAnimationConfiguration = .popUp(withInterItemSpacing: 7)

                actionButton.open(animated: false)

                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct with items configured with closure") {
                actionButton.addItem(title: "123", image: #imageLiteral(resourceName: "Like"))

                actionButton.configureDefaultItem { item in
                    item.titleLabel.font = UIFont(name: "Courier", size: 30)
                    item.titleLabel.textColor = .magenta
                    item.circleView.color = .red
                    item.circleView.highlightedColor = .blue
                    item.imageView.tintColor = .yellow

                    item.layer.shadowColor = UIColor.cyan.cgColor
                    item.layer.shadowOpacity = 1
                    item.layer.shadowOffset = CGSize(width: -2, height: -2)
                    item.layer.shadowRadius = 0
                }

                actionButton.addItem(title: "456", image: #imageLiteral(resourceName: "Balloon"))
                actionButton.open(animated: false)

                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct when only image color is changed") {
                actionButton.buttonImageColor = .red
                actionButton.addItem(title: "123", image: #imageLiteral(resourceName: "Like"))
                actionButton.addItem(title: "456", image: #imageLiteral(resourceName: "Balloon"))
                actionButton.open(animated: false)

                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct with smaller image size") {
                actionButton.buttonImageSize = CGSize(width: 10, height: 10)
                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct with bigger image size") {
                actionButton.buttonImageSize = CGSize(width: 40, height: 40)
                expect(superview).to(haveValidSnapshot())
            }

            context("when multiple items are added") {
                var actionCount = 0

                beforeEach {
                    actionCount = 0
                    actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate)) { _ in
                        actionCount += 1
                    }
                    actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Balloon").withRenderingMode(.alwaysTemplate))
                }

                it("opens when tapped") {
                    actionButton.sendActions(for: .touchUpInside)
                    expect(actionButton.buttonState) == .opening
                    expect(actionButton.buttonState).toEventually(equal(.open))
                }

                it("closes when tapped twice") {
                    actionButton.sendActions(for: .touchUpInside)
                    actionButton.sendActions(for: .touchUpInside)
                    expect(actionButton.buttonState) == .closing
                    expect(actionButton.buttonState).toEventually(equal(.closed))
                }

                it("closes when tapped thrice") {
                    actionButton.sendActions(for: .touchUpInside)
                    actionButton.sendActions(for: .touchUpInside)
                    actionButton.sendActions(for: .touchUpInside)
                    expect(actionButton.buttonState) == .closing
                    expect(actionButton.buttonState).toEventually(equal(.closed))
                }

                context("and is opened") {
                    beforeEach {
                        actionButton.open(animated: false)
                    }

                    it("has state open") {
                        expect(actionButton.buttonState) == .open
                    }

                    it("items look correct") {
                        expect(superview).to(haveValidSnapshot())
                    }

                    it("items look correct highlighted") {
                        let item = actionButton.items[0]
                        item.isHighlighted = true
                        expect(item.isHighlighted).to(beTrue())
                        expect(superview).to(haveValidSnapshot())
                    }

                    it("items look correct highlighted with custom highlighted color") {
                        let item = actionButton.items[0]
                        item.circleView.highlightedColor = .purple
                        item.isHighlighted = true
                        expect(item.isHighlighted).to(beTrue())
                        expect(superview).to(haveValidSnapshot())
                    }

                    it("can't be opened again") {
                        actionButton.open(animated: true)
                        expect(actionButton.buttonState) != .opening
                    }

                    context("and overlay is tapped") {
                        beforeEach {
                            actionButton.overlayView.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState) == .closing
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }
                    }

                    context("and button is tapped") {
                        beforeEach {
                            actionButton.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState) == .closing
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }

                        it("does not perform action") {
//                            waitUntil(timeout: 1.5)
                            expect(actionCount) == 0
                        }
                    }

                    context("and item is tapped") {
                        beforeEach {
                            let item = actionButton.items[0]
                            item.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState) == .closing
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }

                        it("performs action") {
                            expect(actionCount).toEventually(equal(1))
                        }
                    }

                    context("with closeAutomatically disabled") {
                        beforeEach {
                            actionButton.closeAutomatically = false
                        }

                        context("and item is tapped") {
                            beforeEach {
                                let item = actionButton.items[0]
                                item.sendActions(for: .touchUpInside)
                            }

                            it("stays open") {
                                expect(actionButton.buttonState) == .open
                            }

                            it("performs action") {
                                expect(actionCount).toEventually(equal(1))
                            }
                        }
                    }

                    context("with closeAutomatically enabled") {
                        beforeEach {
                            actionButton.closeAutomatically = true
                        }

                        context("and item is tapped") {
                            beforeEach {
                                let item = actionButton.items[0]
                                item.sendActions(for: .touchUpInside)
                            }

                            it("closes") {
                                expect(actionButton.buttonState) == .closing
                                expect(actionButton.buttonState).toEventually(equal(.closed))
                            }

                            it("performs action") {
                                expect(actionCount).toEventually(equal(1))
                            }
                        }
                    }

                    context("and is removed from superview") {
                        beforeEach {
                            actionButton.removeFromSuperview()
                        }

                        it("removes related views from superview") {
                            expect(actionButton.overlayView.superview).to(beNil())
                            expect(actionButton.itemContainerView.superview).to(beNil())
                        }

                        it("closes") {
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }
                    }
                }

                context("and is opened and closed") {
                    beforeEach {
                        actionButton.open(animated: false)
                        actionButton.close(animated: false)
                    }

                    it("looks correct") {
                        expect(superview).to(haveValidSnapshot())
                    }

                    it("can't be closed again") {
                        actionButton.close(animated: true)
                        expect(actionButton.buttonState) != .closing
                    }
                }

                context("and is opened animated") {
                    beforeEach {
                        actionButton.open(animated: true)
                    }

                    it("has state opening") {
                        expect(actionButton.buttonState) == .opening
                    }

                    it("has eventually state open") {
                        expect(actionButton.buttonState).toEventually(equal(.open))
                    }

                    context("and button is tapped") {
                        beforeEach {
                            actionButton.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState) == .closing
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }
                    }

                    context("and overlay is tapped") {
                        beforeEach {
                            actionButton.overlayView.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState) == .closing
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }
                    }

                    context("and item is tapped") {
                        beforeEach {
                            let item = actionButton.items[0]
                            item.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState) == .closing
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }

                        it("performs action") {
                            expect(actionCount).toEventually(equal(1))
                        }
                    }

                    context("and item is tapped twice") {
                        beforeEach {
                            let item = actionButton.items[0]
                            item.sendActions(for: .touchUpInside)
                            item.sendActions(for: .touchUpInside)
                        }

                        it("closes") {
                            expect(actionButton.buttonState) == .closing
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }

                        it("performs action once") {
                            expect(actionCount).toEventually(equal(1))
                        }
                    }

                    context("and is removed from superview") {
                        beforeEach {
                            actionButton.removeFromSuperview()
                        }

                        it("removes related views from superview") {
                            expect(actionButton.overlayView.superview).to(beNil())
                            expect(actionButton.itemContainerView.superview).to(beNil())
                        }

                        it("closes") {
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }
                    }
                }

                context("and is closed animated") {
                    beforeEach {
                        actionButton.open(animated: false)
                        actionButton.close(animated: true)
                    }

                    it("has state closing") {
                        expect(actionButton.buttonState) == .closing
                    }

                    it("has eventually state closed") {
                        expect(actionButton.buttonState).toEventually(equal(.closed))
                    }

                    context("and is removed from superview") {
                        beforeEach {
                            actionButton.removeFromSuperview()
                        }

                        it("removes related views from superview") {
                            expect(actionButton.overlayView.superview).to(beNil())
                            expect(actionButton.itemContainerView.superview).to(beNil())
                        }

                        it("closes") {
                            expect(actionButton.buttonState).toEventually(equal(.closed))
                        }
                    }
                }

                context("and is opened animated with open image") {
                    beforeEach {
                        actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "Dots"))
                        actionButton.open(animated: true)
                    }

                    it("eventually shows open image") {
                        expect(actionButton.imageView.image).toEventually(equal(#imageLiteral(resourceName: "Dots")))
                    }
                }

                context("and is closed animated with open image") {
                    beforeEach {
                        actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "Dots"))
                        actionButton.open(animated: false)
                        actionButton.close(animated: true)
                    }

                    it("eventually shows default image") {
                        expect(actionButton.imageView.image).toEventually(equal(actionButton.buttonImage))
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
                        expect(superview).to(haveValidSnapshot())
                    }
                }

                context("and all but one item are removed") {
                    beforeEach {
                        for (index, item) in actionButton.items.enumerated() {
                            if index > 0 {
                                actionButton.removeItem(item)
                            }
                        }
                    }

                    it("has the correct number of items") {
                        expect(actionButton.items.count) == 1
                    }

                    it("looks correct") {
                        expect(superview).to(haveValidSnapshot())
                    }

                    it("looks correct when opened") {
                        actionButton.open(animated: false)
                        expect(superview).to(haveValidSnapshot())
                    }
                }

                context("and the first item is removed") {
                    var first: JJActionItem!
                    var result: JJActionItem?
                    beforeEach {
                        first = actionButton.items.first
                        result = actionButton.removeItem(first)
                    }

                    it("returns the first item") {
                        expect(result).notTo(beNil())
                        expect(result) == first
                    }
                }

                context("and an item not from the list is removed") {
                    var result: JJActionItem?
                    beforeEach {
                        let item = JJActionItem()
                        result = actionButton.removeItem(item)
                    }

                    it("has the correct number of items") {
                        expect(actionButton.items.count) == 2
                    }

                    it("returns nil") {
                        expect(result).to(beNil())
                    }
                }
            }

            context("when 1 item is added") {
                var actionCount = 0

                beforeEach {
                    actionCount = 0
                    actionButton.addItem(title: "item", image: #imageLiteral(resourceName: "Balloon").withRenderingMode(.alwaysTemplate)) { _ in
                        actionCount += 1
                    }
                }

                it("looks correct") {
                    expect(superview).to(haveValidSnapshot())
                }

                context("and button is tapped") {
                    beforeEach {
                        actionButton.sendActions(for: .touchUpInside)
                    }

                    it("stays closed") {
                        expect(actionButton.buttonState) == .closed
                    }

                    it("performs action") {
                        expect(actionCount).toEventually(equal(1))
                    }
                }

                context("and is opened") {
                    beforeEach {
                        actionButton.open(animated: false)
                    }

                    it("has state closed") {
                        expect(actionButton.buttonState) == .closed
                    }

                    it("looks correct") {
                        expect(superview).to(haveValidSnapshot())
                    }
                }

                context("and is opened with handle single action directly disabled") {
                    beforeEach {
                        actionButton.handleSingleActionDirectly = false
                        actionButton.open(animated: false)
                    }

                    it("opens") {
                        expect(actionButton.buttonState) == .open
                    }

                    it("looks correct") {
                        expect(superview).to(haveValidSnapshot())
                    }
                }
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
                    actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Balloon").withRenderingMode(.alwaysTemplate))
                }

                it("stays closed") {
                    actionButton.sendActions(for: .touchUpInside)
                    expect(actionButton.buttonState) == .closed
                }
            }
        }

        describe("JJFloatingActionButton loaded from xib") {
            var actionButton: JJFloatingActionButton?

            beforeEach {
                let bundle = Bundle(for: Self.self)
                actionButton = bundle.loadNibNamed("JJFloatingActionButton", owner: nil)?.first as? JJFloatingActionButton
            }

            it("looks correct") {
                expect(actionButton).to(haveValidSnapshot())
            }
        }

        describe("JJFloatingActionButton using single item initializer") {
            var actionButton: JJFloatingActionButton!
            var actionCount = 0

            beforeEach {
                actionCount = 0
                actionButton = JJFloatingActionButton(image: #imageLiteral(resourceName: "Favorite"), action: { _ in
                    actionCount += 1
                })
            }

            it("has one item") {
                expect(actionButton.items.count) == 1
            }

            it("has the correct icon") {
                expect(actionButton.items.first?.buttonImage) == #imageLiteral(resourceName: "Favorite")
            }

            it("performs action when tapped") {
                actionButton.sendActions(for: .touchUpInside)
                expect(actionCount).toEventually(equal(1))
            }
        }

        describe("JJFloatingActionButton using layout constraints") {
            let superviewFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 300))

            var actionButton: JJFloatingActionButton!
            var superview: UIView!

            beforeEach {
                superview = UIView(frame: superviewFrame)
                superview.backgroundColor = .white

                actionButton = JJFloatingActionButton()
                superview.addSubview(actionButton)

                actionButton.translatesAutoresizingMaskIntoConstraints = false
                actionButton.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16).isActive = true
                actionButton.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -16).isActive = true
            }

            it("looks correct") {
                expect(superview).to(haveValidSnapshot())
            }

            it("looks correct when diameter is set") {
                actionButton.buttonDiameter = 100
                expect(superview).to(haveValidSnapshot())
            }
        }
    }
}
