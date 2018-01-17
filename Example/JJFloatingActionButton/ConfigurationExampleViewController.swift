//
//  ConfigurationExampleViewController.swift
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

import JJFloatingActionButton
import UIKit

internal class ConfigurationExampleViewController: UIViewController {

    fileprivate let actionButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton.buttonColor = .red
        actionButton.defaultButtonImage = #imageLiteral(resourceName: "Dots")
        actionButton.buttonOpeningStyle = .transition(image: #imageLiteral(resourceName: "X"))
        actionButton.buttonImageColor = .white
        actionButton.shadowColor = .black
        actionButton.shadowOffset = CGSize(width: 0, height: 1)
        actionButton.shadowOpacity = Float(0.5)
        actionButton.shadowRadius = CGFloat(2)
        actionButton.itemTitleFont = .boldSystemFont(ofSize: UIFont.systemFontSize)
        actionButton.itemButtonColor = .white
        actionButton.itemImageColor = .red
        actionButton.itemTitleColor = .white
        actionButton.itemShadowColor = .black
        actionButton.itemShadowOffset = CGSize(width: 0, height: 1)
        actionButton.itemShadowOpacity = Float(0.4)
        actionButton.itemShadowRadius = CGFloat(2)
        actionButton.itemSizeRatio = CGFloat(0.75)
        actionButton.itemOpeningStyle = .popUp(interItemSpacing: 14)
        actionButton.overlayView.backgroundColor = UIColor(hue: 0.31, saturation: 0.37, brightness: 0.10, alpha: 0.30)

        actionButton.addItem(title: "Balloon", image: #imageLiteral(resourceName: "Baloon")) { item in
            Helper.showAlert(for: item)
        }

        actionButton.addItem(title: "Like", image: #imageLiteral(resourceName: "Like")) { item in
            Helper.showAlert(for: item)
        }

        let item3 = actionButton.addItem()
        item3.circleView.color = .black
        item3.imageView.image = #imageLiteral(resourceName: "Owl")
        item3.imageView.tintColor = .white
        item3.titleLabel.text = "Owl"
        item3.action = { item in
            Helper.showAlert(for: item)
        }

        actionButton.display(inViewController: self)
    }
}

extension ConfigurationExampleViewController: JJFloatingActionButtonDelegate {

    func floatingActionButtonWillOpen(_ button: JJFloatingActionButton) {
        print("Action button will open: \(button.state)")
    }

    func floatingActionButtonDidOpen(_ button: JJFloatingActionButton) {
        print("Action button did open: \(button.state)")
    }

    func floatingActionButtonWillClose(_ button: JJFloatingActionButton) {
        print("Action button will close: \(button.state)")
    }

    func floatingActionButtonDidClose(_ button: JJFloatingActionButton) {
        print("Action button did close: \(button.state)")
    }
}
