//
//  JJCircleViewSpec.swift
//  JJFloatingActionButton_Example
//
//  Created by Jochen on 06.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

@testable import JJFloatingActionButton
import Nimble
import Nimble_Snapshots
import Quick

class JJCircleViewSpec: QuickSpec {
    
    override func spec() {
        
        describe("JJCircleView loaded from xib") {
            var circleView: JJCircleView?
            
            beforeEach {
                let bundle = Bundle(for: type(of: self))
                circleView = bundle.loadNibNamed("JJCircleView", owner: nil)?.first as? JJCircleView
            }
            
            it("looks correct") {
                expect(circleView) == snapshot()
            }
        }
    }
}
