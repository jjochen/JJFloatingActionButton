//
//  JJCircleImageViewTests.swift
//  JJFloatingActionButton_Tests
//
//  Created by Jochen on 16.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import JJFloatingActionButton

class JJCircleImageView_Tests: QuickSpec {

    override func spec() {

        describe("JJCircleImageView") {

            var circleView: JJCircleImageView!
            beforeEach {
                circleView = JJCircleImageView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
                setNimbleTolerance(0.03)
            }

            it("looks correct by default") {
                expect(circleView) == snapshot()
            }

            context("when configured with light color") {
                beforeEach {
                    circleView.circleColor = UIColor(hue: 0.5, saturation: 0.7, brightness: 0.7, alpha: 1)
                    circleView.imageColor = UIColor.blue
                    circleView.image = UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)
                }

                it("looks correct") {
                    expect(circleView) == snapshot()
                }

                it("looks correct highlighted") {
                    circleView.isHighlighted = true
                    expect(circleView) == snapshot()
                }
            }

            context("when configured with dark color") {
                beforeEach {
                    circleView.circleColor = UIColor(hue: 0.5, saturation: 0.7, brightness: 0.3, alpha: 1)
                    circleView.imageColor = UIColor.blue
                    circleView.image = UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)
                }

                it("looks correct") {
                    expect(circleView) == snapshot()
                }

                it("looks correct highlighted") {
                    circleView.isHighlighted = true
                    expect(circleView) == snapshot()
                }
            }

            context("when configured with custom highligted color") {
                beforeEach {
                    circleView.circleColor = UIColor(hue: 0.5, saturation: 0.7, brightness: 0.7, alpha: 1)
                    circleView.imageColor = UIColor.blue
                    circleView.image = UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)
                    circleView.highligtedCircleColor = UIColor.yellow
                }

                it("looks correct") {
                    expect(circleView) == snapshot()
                }

                it("looks correct highlighted") {
                    circleView.isHighlighted = true
                    expect(circleView) == snapshot()
                }
            }
        }
    }
}
