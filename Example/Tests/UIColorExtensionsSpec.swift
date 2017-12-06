//
//  UIColorExtensionsSpec.swift
//  JJFloatingActionButton_Tests
//
//  Created by Jochen on 06.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//


@testable import JJFloatingActionButton
import Nimble
import Quick

class UIColorExtensionsSpec: QuickSpec {
    
    override func spec() {
        
        describe("UIColor") {
            
            context("when light") {
                var originalColor: UIColor!
                var highlightedColor: UIColor!
                
                beforeEach {
                    originalColor = UIColor(hue:0.63, saturation:0.64, brightness:0.70, alpha:1.00)
                    highlightedColor = originalColor.highlighted
                }
                
                it("has a lower brightness in highligted version") {
                    
                    var originalBrightness = CGFloat(0)
                    originalColor.getHue(nil, saturation: nil, brightness: &originalBrightness, alpha: nil)
                    
                    var highlightedBrightness = CGFloat(0)
                    highlightedColor.getHue(nil, saturation: nil, brightness: &highlightedBrightness, alpha: nil)
                    
                    expect(highlightedBrightness).to(beLessThan(originalBrightness))
                }
            }
            
            context("when dark") {
                var originalColor: UIColor!
                var highlightedColor: UIColor!
                
                beforeEach {
                    originalColor = UIColor(hue:0.63, saturation:0.64, brightness:0.30, alpha:1.00)
                    highlightedColor = originalColor.highlighted
                }
                
                it("has a greater brightness in highligted version") {
                    
                    var originalBrightness = CGFloat(0)
                    originalColor.getHue(nil, saturation: nil, brightness: &originalBrightness, alpha: nil)
                    
                    var highlightedBrightness = CGFloat(0)
                    highlightedColor.getHue(nil, saturation: nil, brightness: &highlightedBrightness, alpha: nil)
                    
                    expect(highlightedBrightness).to(beGreaterThan(originalBrightness))
                }
            }
        }
    }
}

