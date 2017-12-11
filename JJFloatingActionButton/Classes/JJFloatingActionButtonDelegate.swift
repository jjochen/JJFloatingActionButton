//
//  JJFloatingActionButtonDelegate.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 07.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import Foundation

@objc public protocol JJFloatingActionButtonDelegate {

    /// Is called before opening animation. Button state is .opening.
    @objc optional func floatingActionButtonWillOpen(_ button: JJFloatingActionButton)

    /// Is called after opening animation. Button state is .opened.
    @objc optional func floatingActionButtonDidOpen(_ button: JJFloatingActionButton)

    /// Is called before closing animation. Button state is .closing.
    @objc optional func floatingActionButtonWillClose(_ button: JJFloatingActionButton)

    /// Is called after closing animation. Button state is .closed.
    @objc optional func floatingActionButtonDidClose(_ button: JJFloatingActionButton)
}
