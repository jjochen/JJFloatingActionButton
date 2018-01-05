//
//  FirstViewController.swift
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

internal class FirstViewController: UIViewController {

    internal let actionButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton.buttonColor = UIColor.red
        actionButton.defaultButtonImage = UIImage(named: "Plus")?.withRenderingMode(.alwaysTemplate)
        actionButton.buttonImageColor = UIColor.white
        actionButton.shadowColor = UIColor.black
        actionButton.shadowOffset = CGSize(width: 0, height: 1)
        actionButton.shadowOpacity = Float(0.5)
        actionButton.shadowRadius = CGFloat(2)
        actionButton.itemTitleFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        actionButton.itemButtonColor = UIColor.white
        actionButton.itemImageColor = UIColor.red
        actionButton.itemTitleColor = UIColor.white
        actionButton.itemShadowColor = UIColor.black
        actionButton.itemShadowOffset = CGSize(width: 0, height: 1)
        actionButton.itemShadowOpacity = Float(0.4)
        actionButton.itemShadowRadius = CGFloat(2)
        actionButton.itemSizeRatio = CGFloat(0.75)
        actionButton.interItemSpacing = CGFloat(12)
        actionButton.rotationAngle = -CGFloat.pi / 4
        actionButton.overlayView.backgroundColor = UIColor(white: 0, alpha: 0.5)

        actionButton.addItem(title: "item 1", image: #imageLiteral(resourceName: "Baloon").withRenderingMode(.alwaysTemplate)) { item in
            self.showMessage(for: item)
        }

        actionButton.addItem(title: "item 2", image: #imageLiteral(resourceName: "Like").withRenderingMode(.alwaysTemplate)) { item in
            self.showMessage(for: item)
        }

        let item3 = actionButton.addItem()
        item3.circleView.color = .black
        item3.imageView.image = #imageLiteral(resourceName: "Owl").withRenderingMode(.alwaysTemplate)
        item3.imageView.tintColor = .white
        item3.titleLabel.text = "item 3"
        item3.action = { item in
            self.showMessage(for: item)
        }

        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        } else {
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            actionButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -16).isActive = true
        }
    }
}

extension FirstViewController: JJFloatingActionButtonDelegate {

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

extension FirstViewController {

    func showMessage(for item: JJActionItem) {
        let alertController = UIAlertController(title: item.titleLabel.text, message: "button tapped!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
