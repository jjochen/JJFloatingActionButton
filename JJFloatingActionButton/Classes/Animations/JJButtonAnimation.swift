//
//  JJButtonAnimation.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 22.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import Foundation


internal protocol JJButtonAnimation {

    func open(animated: Bool, group: DispatchGroup)
    func close(animated: Bool, group: DispatchGroup)

}
