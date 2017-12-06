//
//  SecondViewController.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 06.11.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class SecondViewController: UIViewController {
    
    @IBOutlet weak var actionButton: JJFloatingActionButton!
    
    override func viewDidLoad() {
        
        actionButton.addItem(title: "item", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)) { item in
            
            let alertController = UIAlertController(title: item.titleLabel.text, message: "button tapped!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
