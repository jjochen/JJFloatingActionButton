//
//  JJButtonAnimation.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 22.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

internal protocol JJButtonAnimation {

    func open(animated: Bool, group: DispatchGroup)
    func close(animated: Bool, group: DispatchGroup)
}
