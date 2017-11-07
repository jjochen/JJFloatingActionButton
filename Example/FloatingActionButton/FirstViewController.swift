//
//  FirstViewController.swift
//  FloatingActionButton
//
//  Created by Jochen on 06.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let actionButton = JJFloatingActionButton()

        actionButton.addItem(title: "item 1", image: UIImage(named: "first")?.withRenderingMode(.alwaysTemplate)) { item in
            self.showMessage(for: item)
        }

        actionButton.addItem(title: "item 2", image: UIImage(named: "second")?.withRenderingMode(.alwaysTemplate)) { item in
            self.showMessage(for: item)
        }

        actionButton.addItem(title: "item 3") { item in
            self.showMessage(for: item)
        }

        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
}

fileprivate extension FirstViewController {
    func showMessage(for item: JJActionItem) {
        let alertController = UIAlertController(title: item.title, message: "button tapped!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
