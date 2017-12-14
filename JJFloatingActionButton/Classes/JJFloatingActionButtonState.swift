//
//  JJFloatingActionButtonState.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 07.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import Foundation

/// Button state.
///
///   - closed: no items are visible
///   - open: items are fully visible
///   - opening: during opening animation
///   - closing: during closing animation
///
@objc public enum JJFloatingActionButtonState: Int {
    case closed
    case open
    case opening
    case closing
}
