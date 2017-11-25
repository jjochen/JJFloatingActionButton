//
//  UIColor+Extensions.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 25.11.17.
//

import UIKit

internal extension UIColor {

    class var defaultButtonColor: UIColor {
        return UIColor(hue: 0.31, saturation: 0.37, brightness: 0.76, alpha: 1.00)
    }

    class var defaultHighlightedButtonColor: UIColor {
        return UIColor(hue: 0.31, saturation: 0.37, brightness: 0.66, alpha: 1.00)
    }

    var highlightedVersion: UIColor {
        var hue = CGFloat(0)
        var satuaration = CGFloat(0)
        var brightness = CGFloat(0)
        var alpha = CGFloat(0)
        getHue(&hue, saturation: &satuaration, brightness: &brightness, alpha: &alpha)
        let newBrightness = brightness > 0.5 ? brightness - 0.1 : brightness + 0.1
        return UIColor(hue: hue, saturation: satuaration, brightness: newBrightness, alpha: alpha)
    }
}
