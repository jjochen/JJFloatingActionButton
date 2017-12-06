//
//  FirstViewController_Tests.swift
//  JJFloatingActionButton_Tests
//
//  Created by Jochen on 27.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import JJFloatingActionButton
@testable import JJFloatingActionButton_Example
import Nimble
import Quick

class FirstViewControllerSpec: QuickSpec {

    override func spec() {

        var viewController: FirstViewController!

        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController

            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = viewController
            window.makeKeyAndVisible()

            _ = viewController.view
        }

        describe("the action button") {

            it("has a superview") {
                expect(viewController.actionButton.superview).toNot(beNil())
            }

            it("has multiple items") {
                expect(viewController.actionButton.items.count).to(beGreaterThan(0))
            }

            it("opens when tapped") {
                viewController.actionButton.sendActions(for: .touchUpInside)
                expect(viewController.actionButton.buttonState).toEventually(equal(JJFloatingActionButtonState.open))
            }

            context("when opened") {
                beforeEach {
                    viewController.actionButton.open(animated: false)
                }

                it("shows a message when 1st item is tapped") {
                    let item = viewController.actionButton.items[0]
                    item.sendActions(for: .touchUpInside)
                    expect(viewController.presentedViewController).toNotEventually(beNil())
                }

                it("shows a message when 2st item is tapped") {
                    let item = viewController.actionButton.items[1]
                    item.sendActions(for: .touchUpInside)
                    expect(viewController.presentedViewController).toNotEventually(beNil())
                }

                it("shows a message when 3st item is tapped") {
                    let item = viewController.actionButton.items[2]
                    item.sendActions(for: .touchUpInside)
                    expect(viewController.presentedViewController).toNotEventually(beNil())
                }
            }
        }
    }
}
