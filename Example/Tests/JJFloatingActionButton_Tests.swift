//
//  FloatingActionButtonTests.swift
//  FloatingActionButtonTests
//
//  Created by Jochen on 06.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import JJFloatingActionButton

class JJFloatingActionButton_Tests: QuickSpec {

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

                setNimbleTolerance(0.01)
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

            it("looks correct configured") {
                actionButton.buttonColor = UIColor.blue
                actionButton.defaultButtonImage = UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)
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

                actionButton.addItem(title: "item 1", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate))
                actionButton.addItem(title: "item 2", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate))

                actionButton.open(animated: false)

                expect(superview) == snapshot()
            }

            it("looks correct configured after adding the items") {
                actionButton.addItem(title: "item 1", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate))
                actionButton.addItem(title: "item 2", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate))

                actionButton.buttonColor = UIColor.blue
                actionButton.defaultButtonImage = UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)
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
                    actionButton.addItem(title: "item 1", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate)) { _ in
                        action = "done!"
                    }
                    actionButton.addItem(title: "item 2", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate))
                }

                it("opens when tapped") {
                    actionButton.sendActions(for: .touchUpInside)
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
            }

            context("when 1 item is added") {
                var action = "not done"
                beforeEach {
                    actionButton.addItem(title: "item", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)) { _ in
                        action = "done!"
                    }
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

                it("looks correct") {
                    expect(superview) == snapshot()
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
            }
        }
    }
}
