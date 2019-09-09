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

                setNimbleTolerance(0.004)
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
                actionButton.highlightedButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with light color") {
                actionButton.buttonColor = UIColor(hue: 0.4, saturation: 0.9, brightness: 0.7, alpha: 1)
                actionButton.highlightedButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with custom color") {
                actionButton.highlightedButtonColor = .orange
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTrue())
                expect(superview) == snapshot()
            }

            it("looks correct configured") {
                actionButton.buttonColor = .blue
                actionButton.highlightedButtonColor = .orange
                actionButton.buttonImage = #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate)
                actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "Baloon"))
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
                actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate))

                actionButton.open(animated: false)

                expect(superview) == snapshot()
            }

            it("looks correct configured after adding the items") {
                actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate))
                actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate))

                actionButton.buttonColor = .blue
                actionButton.buttonImage = #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate)
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

                expect(superview) == snapshot()
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

                actionButton.addItem(title: "456", image: #imageLiteral(resourceName: "Baloon"))
                actionButton.open(animated: false)

                expect(superview) == snapshot()
            }

            it("looks correct when only image color is changed") {
                actionButton.buttonImageColor = .red
                actionButton.addItem(title: "123", image: #imageLiteral(resourceName: "Like"))
                actionButton.addItem(title: "456", image: #imageLiteral(resourceName: "Baloon"))
                actionButton.open(animated: false)

                expect(superview) == snapshot()
            }

            it("looks correct with smaller image size") {
                actionButton.buttonImageSize = CGSize(width: 10, height: 10)
                expect(superview) == snapshot()
            }

            it("looks correct with bigger image size") {
                actionButton.buttonImageSize = CGSize(width: 40, height: 40)
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
                        let item = actionButton.items[0]
                        item.circleView.highlightedColor = .purple
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

        describe("JJFloatingActionButton using single item initializer") {
            var actionButton: JJFloatingActionButton!
            var action = "not done"

            beforeEach {
                actionButton = JJFloatingActionButton(image: #imageLiteral(resourceName: "Favourite"), action: { _ in
                    action = "done!"
                })
            }

            it("has one item") {
                expect(actionButton.items.count) == 1
            }

            it("has the correct icon") {
                expect(actionButton.items.first?.buttonImage) == #imageLiteral(resourceName: "Favourite")
            }

            it("performs action when tapped") {
                actionButton.sendActions(for: .touchUpInside)
                expect(action).toEventually(equal("done!"))
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
                expect(superview) == snapshot()
            }

            it("looks correct when diameter is set") {
                actionButton.buttonDiameter = 100
                expect(superview) == snapshot()
            }
        }
    }
}
