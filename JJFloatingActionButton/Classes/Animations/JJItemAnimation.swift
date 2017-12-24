//
//  JJItemAnimation.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 22.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal protocol JJItemAnimation {

    func addItems(to containerView: UIView)
    func open(animated: Bool, group: DispatchGroup)
    func close(animated: Bool, group: DispatchGroup)
    func removeItems()
}
