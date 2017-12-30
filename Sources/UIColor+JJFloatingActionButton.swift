//
//  UIColor+Extensions.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 25.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal extension UIColor {

    var highlighted: UIColor {
        var hue = CGFloat(0)
        var satuaration = CGFloat(0)
        var brightness = CGFloat(0)
        var alpha = CGFloat(0)
        getHue(&hue, saturation: &satuaration, brightness: &brightness, alpha: &alpha)
        let newBrightness = brightness > 0.5 ? brightness - 0.1 : brightness + 0.1
        return UIColor(hue: hue, saturation: satuaration, brightness: newBrightness, alpha: alpha)
    }
}
