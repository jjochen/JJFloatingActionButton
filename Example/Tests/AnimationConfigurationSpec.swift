//
//  AnimationConfigurationSpec.swift
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

class AnimationConfigurationSpec: QuickSpec {
    override func spec() {
        describe("JJFloatingActionButton") {
            var actionButton: JJFloatingActionButton!
            var superview: UIView!

            beforeEach {
                assert(UIApplication.shared.keyWindow != nil)
                let windowWidth = UIApplication.shared.keyWindow!.bounds.size.width

                var superviewFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 300))
                superviewFrame.origin.x = windowWidth - superviewFrame.size.width
                let actionButtonFrame = CGRect(origin: CGPoint(x: 130, y: 230), size: CGSize(width: 56, height: 56))

                superview = UIView(frame: superviewFrame)
                superview.backgroundColor = .white

                actionButton = JJFloatingActionButton(frame: actionButtonFrame)
                superview.addSubview(actionButton)

                actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))
                actionButton.addItem(image: #imageLiteral(resourceName: "Owl"))

                setNimbleTolerance(0.003)
            }

            it("is on the right side of the screen") {
                expect(actionButton.isOnLeftSideOfScreen).to(beFalse())
            }

            it("is on the right side of nothing") {
                expect(actionButton.isOnLeftSide(ofView: nil)).to(beFalse())
            }

            context("when using pop up style") {
                beforeEach {
                    actionButton.itemAnimationConfiguration = .popUp(withInterItemSpacing: 10)
                    actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "Owl"))
                }

                it("it looks correct") {
                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }
            }

            context("when using slide in style") {
                beforeEach {
                    actionButton.itemAnimationConfiguration = .slideIn(withInterItemSpacing: 10)
                    actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "Owl"))
                }

                it("it looks correct") {
                    actionButton.open(animated: false)
                    expect(superview) == snapshot()
                }
            }

            context("when using circular pop up style") {
                beforeEach {
                    actionButton.itemAnimationConfiguration = .circularPopUp(withRadius: 100)
                    actionButton.buttonAnimationConfiguration = .rotation(toAngle: -CGFloat.pi / 3)
                    actionButton.items = []
                }

                it("it looks correct with 3 items") {
                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Owl"))

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with 2 items") {
                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with 1 item") {
                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.handleSingleActionDirectly = false

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("looks correct when item have background color") {
                    actionButton.configureDefaultItem({ item in
                        item.backgroundColor = .red
                    })

                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))
                    actionButton.addItem(title: "title", image: #imageLiteral(resourceName: "Owl"))

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct when opened and closed") {
                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Owl"))

                    actionButton.open(animated: false)
                    actionButton.close(animated: false)

                    expect(superview) == snapshot()
                }
            }

            context("when using circular slide in style") {
                beforeEach {
                    actionButton.itemAnimationConfiguration = .circularSlideIn(withRadius: 80)
                    actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "Owl"))
                }

                it("it looks correct") {
                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }
            }

            context("when using custom item animation configuration") {
                let configuration = JJItemAnimationConfiguration()

                beforeEach {
                    configuration.openState = JJItemPreparation { item, _, _, _ in
                        item.alpha = 1
                    }
                    actionButton.itemAnimationConfiguration = configuration
                }

                it("it looks correct with items scaled") {
                    configuration.itemLayout = .verticalLine(withInterItemSpacing: 10)
                    configuration.closedState = .scale()

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with horizontal offset") {
                    configuration.itemLayout = .verticalLine(withInterItemSpacing: 10)
                    configuration.closedState = .horizontalOffset(distance: 30, scale: 0.5)

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with items offseted") {
                    configuration.itemLayout = .verticalLine(withInterItemSpacing: 10)
                    configuration.closedState = .offset(translationX: -20, translationY: 10)

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with circular offset items") {
                    configuration.itemLayout = .circular(withRadius: 50)
                    configuration.closedState = .circularOffset(distance: 50, scale: 0.5)

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }
            }
        }

        describe("JJFloatingActionButton on the left") {
            var actionButton: JJFloatingActionButton!
            var superview: UIView!

            beforeEach {
                let superviewFrame = CGRect(origin: .zero, size: CGSize(width: 200, height: 400))
                let actionButtonFrame = CGRect(origin: CGPoint(x: 50, y: 330), size: CGSize(width: 56, height: 56))

                superview = UIView(frame: superviewFrame)
                superview.backgroundColor = .white

                actionButton = JJFloatingActionButton(frame: actionButtonFrame)
                superview.addSubview(actionButton)

                actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))
                actionButton.addItem(image: #imageLiteral(resourceName: "Owl"))

                setNimbleTolerance(0.002)
            }

            it("is on the left side of the screen") {
                expect(actionButton.isOnLeftSideOfScreen).to(beTrue())
            }

            context("when using circular pop up style") {
                beforeEach {
                    actionButton.itemAnimationConfiguration = .circularPopUp(withRadius: 100)
                    actionButton.buttonAnimationConfiguration = .rotation(toAngle: -CGFloat.pi / 3)
                    actionButton.items = []
                }

                it("it looks correct with 3 items") {
                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Owl"))

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with 2 items") {
                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.addItem(image: #imageLiteral(resourceName: "Baloon"))

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with 1 item") {
                    actionButton.addItem(image: #imageLiteral(resourceName: "Like"))
                    actionButton.handleSingleActionDirectly = false

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }
            }

            context("when using custom item animation configuration") {
                let configuration = JJItemAnimationConfiguration()

                beforeEach {
                    configuration.openState = JJItemPreparation { item, _, _, _ in
                        item.alpha = 1
                    }
                    actionButton.itemAnimationConfiguration = configuration
                }

                it("it looks correct with horizontal offset") {
                    configuration.itemLayout = .verticalLine(withInterItemSpacing: 10)
                    configuration.closedState = .horizontalOffset(distance: 30, scale: 0.5)

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with items offseted") {
                    configuration.itemLayout = .verticalLine(withInterItemSpacing: 10)
                    configuration.closedState = .offset(translationX: -20, translationY: 10)

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                it("it looks correct with circular offset items") {
                    configuration.itemLayout = .circular(withRadius: 50)
                    configuration.closedState = .circularOffset(distance: 50, scale: 0.5)

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }
            }

            context("with rtl language") {
                beforeEach {
                    actionButton.items = []

                    superview.semanticContentAttribute = .forceRightToLeft
                    actionButton.semanticContentAttribute = .forceRightToLeft

                    actionButton.configureDefaultItem { item in
                        item.titleLabel.font = UIFont(name: "Courier", size: 12)
                        item.semanticContentAttribute = .forceRightToLeft
                    }

                    let item1 = actionButton.addItem(title: "leading", image: #imageLiteral(resourceName: "Like"))
                    item1.titlePosition = .leading
                    let item2 = actionButton.addItem(title: "trailing", image: #imageLiteral(resourceName: "Baloon"))
                    item2.titlePosition = .trailing
                    let item3 = actionButton.addItem(title: "right", image: #imageLiteral(resourceName: "Like"))
                    item3.titlePosition = .right
                    let item4 = actionButton.addItem(title: "left", image: #imageLiteral(resourceName: "Baloon"))
                    item4.titlePosition = .left
                    let item5 = actionButton.addItem(title: "hidden", image: #imageLiteral(resourceName: "Baloon"))
                    item5.titlePosition = .hidden
                }

                it("looks correct") {
                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }

                // disabled for now. Fails on older operating sistems. ToDo!
                xit("looks correct with slide in configuration") {
                    let configuration = JJItemAnimationConfiguration()
                    configuration.openState = JJItemPreparation { item, _, _, _ in
                        item.alpha = 1
                    }
                    configuration.closedState = .horizontalOffset(distance: 40, scale: 0.6)
                    actionButton.itemAnimationConfiguration = configuration

                    actionButton.open(animated: false)

                    expect(superview) == snapshot()
                }
            }
        }
    }
}
