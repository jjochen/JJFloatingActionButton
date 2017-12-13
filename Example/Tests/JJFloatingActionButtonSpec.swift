//
//  FloatingActionButtonTests.swift
//  FloatingActionButtonTests
//
//  Created by Jochen on 06.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
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

                setNimbleTolerance(0)
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
                expect(actionButton.isHighlighted).to(beTruthy())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with dark color") {
                actionButton.buttonColor = UIColor(hue: 0.6, saturation: 0.9, brightness: 0.3, alpha: 1)
                actionButton.highlightedItemButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTruthy())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with light color") {
                actionButton.buttonColor = UIColor(hue: 0.4, saturation: 0.9, brightness: 0.7, alpha: 1)
                actionButton.highlightedItemButtonColor = nil
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTruthy())
                expect(superview) == snapshot()
            }

            it("looks correct highlighted with custom color") {
                actionButton.highlightedButtonColor = UIColor.orange
                actionButton.isHighlighted = true
                expect(actionButton.isHighlighted).to(beTruthy())
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
                actionButton.overlayColor = UIColor.brown.withAlphaComponent(0.3)
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
                actionButton.overlayColor = UIColor.brown.withAlphaComponent(0.3)
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
                        let item = actionButton.openItems![0]
                        item.isHighlighted = true
                        expect(item.isHighlighted).to(beTruthy())
                        expect(superview) == snapshot()
                    }

                    it("items look correct highlighted with custom highligted color") {
                        actionButton.highlightedItemButtonColor = UIColor.purple
                        let item = actionButton.openItems![0]
                        item.isHighlighted = true
                        expect(item.isHighlighted).to(beTruthy())
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
                            let item = actionButton.openItems![0]
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
    }
}
