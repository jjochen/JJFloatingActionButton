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

class FloatingActionButtonTests: QuickSpec {
    
    override func spec() {
        
        describe("FloatingActionButton") {
            
            var view: JJFloatingActionButton!
            
            beforeEach {
                view = JJFloatingActionButton()
                view.translatesAutoresizingMaskIntoConstraints = false
            }
            
            it("should be there") {
                expect(view) == snapshot()
            }
        }
    }
    
}
