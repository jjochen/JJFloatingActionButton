//
//  Bundle+Extensions.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 05.12.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import Foundation

internal extension Bundle {

    static func assetsBundle() -> Bundle? {
        return resourceBundle(withName: "Assets")
    }

    static func resourceBundle(withName name: String) -> Bundle? {

        let frameworkBundle = Bundle(for: JJFloatingActionButton.self)

        guard let resourceBundleURL = frameworkBundle.url(forResource: name, withExtension: "bundle") else {
            return nil
        }

        let resourceBundle = Bundle(url: resourceBundleURL)

        return resourceBundle
    }
}
