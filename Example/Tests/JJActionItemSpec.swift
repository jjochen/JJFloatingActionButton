//
//  JJActionItemSpec.swift
//  JJFloatingActionButton_Tests
//
//  Created by Jochen on 06.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

@testable import JJFloatingActionButton
import Nimble
import Nimble_Snapshots
import Quick

class JJActionItemSpec: QuickSpec {
    
    override func spec() {
        
        describe("JJActionItem loaded from xib") {
            var actionItem: JJActionItem?
            
            beforeEach {
                let bundle = Bundle(for: type(of: self))
                actionItem = bundle.loadNibNamed("JJActionItem", owner: nil)?.first as? JJActionItem
            }
            
            it("looks correct") {
                expect(actionItem) == snapshot()
            }
        }
    }
}
