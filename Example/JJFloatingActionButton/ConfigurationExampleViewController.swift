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

        configureActionButton()

        view.addSubview(actionButton)

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            actionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        } else {
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            actionButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -16).isActive = true
        }
    }

    fileprivate func configureActionButton() {
        actionButton.handleSingleActionDirectly = false
        actionButton.buttonDiameter = 65
        actionButton.overlayView.backgroundColor = UIColor(hue: 0.31, saturation: 0.37, brightness: 0.10, alpha: 0.30)
        actionButton.buttonImage = #imageLiteral(resourceName: "Dots")
        actionButton.buttonColor = .red
        actionButton.buttonImageColor = .white
        actionButton.buttonImageSize = CGSize(width: 30, height: 30)

        actionButton.buttonAnimationConfiguration = .transition(toImage: #imageLiteral(resourceName: "X"))
        actionButton.itemAnimationConfiguration = .slideIn(withInterItemSpacing: 14)

        actionButton.layer.shadowColor = UIColor.black.cgColor
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        actionButton.layer.shadowOpacity = Float(0.4)
        actionButton.layer.shadowRadius = CGFloat(2)

        actionButton.itemSizeRatio = CGFloat(0.75)
        actionButton.configureDefaultItem { item in
            item.titlePosition = .trailing
            item.titleSpacing = 16

            item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
            item.titleLabel.textColor = .white
            item.buttonColor = .white
            item.buttonImageColor = .red

            item.layer.shadowColor = UIColor.black.cgColor
            item.layer.shadowOffset = CGSize(width: 0, height: 1)
            item.layer.shadowOpacity = Float(0.4)
            item.layer.shadowRadius = CGFloat(2)
        }

        addItems()
    }

    fileprivate func addItems() {
        actionButton.addItem(title: "Balloon", image: #imageLiteral(resourceName: "Baloon")) { item in
            Helper.showAlert(for: item)
        }

        actionButton.addItem(title: "Like", image: #imageLiteral(resourceName: "Like")) { item in
            Helper.showAlert(for: item)
        }

        let owlItem = actionButton.addItem()
        owlItem.titleLabel.text = "Owl"
        owlItem.imageView.image = #imageLiteral(resourceName: "Owl")
        owlItem.buttonColor = .black
        owlItem.buttonImageColor = .white
        owlItem.action = { item in
            Helper.showAlert(for: item)
        }

        let heartItem = actionButton.addItem()
        heartItem.titleLabel.text = "Heart"
        heartItem.imageView.image = #imageLiteral(resourceName: "Favourite")
        heartItem.buttonColor = .clear
        heartItem.buttonImageColor = .red
        heartItem.imageSize = CGSize(width: 30, height: 30)
        heartItem.action = { item in
            Helper.showAlert(for: item)
        }
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
