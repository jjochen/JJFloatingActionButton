//
//  Bundle+Extensions_Tests.swift
//  JJFloatingActionButton_Tests
//
//  Created by Jochen on 05.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

@testable import JJFloatingActionButton
import Nimble
import Quick

class BundleExtensionSpec: QuickSpec {

    override func spec() {

        describe("Resource Bundle") {

            it("is not nil for existing bundle") {
                let bundle = Bundle.resourceBundle(withName: "Assets")
                expect(bundle).toNot(beNil())
            }

            it("is nil for existing bundle") {
                let bundle = Bundle.resourceBundle(withName: "Bssets")
                expect(bundle).to(beNil())
            }
        }

        describe("Assets Bundle") {

            it("is not nil") {
                let bundle = Bundle.assetsBundle()
                expect(bundle).toNot(beNil())
            }
        }
    }
}
