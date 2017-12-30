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
@objc public enum JJFloatingActionButtonState: Int {

    /// No items are visible
    ///
    case closed

    /// Items are fully visible
    ///
    case open

    /// During opening animation
    ///
    case opening

    /// During closing animation
    ///
    case closing
}
