//
//  JJFloatingActionButtonDelegate.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 07.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import Foundation

@objc public protocol JJFloatingActionButtonDelegate {
    @objc optional func floatingActionButtonWillOpen(_ button: JJFloatingActionButton)
    @objc optional func floatingActionButtonDidOpen(_ button: JJFloatingActionButton)
    @objc optional func floatingActionButtonWillClose(_ button: JJFloatingActionButton)
    @objc optional func floatingActionButtonDidClose(_ button: JJFloatingActionButton)
}
