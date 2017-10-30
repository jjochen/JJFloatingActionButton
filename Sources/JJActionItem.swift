//
//  JJActionItem.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 30.10.17.
//

import UIKit

@objc open class JJActionItem: NSObject {
    @objc open var title: String?
    @objc open var icon: UIImage?
    @objc open var action: ((JJActionItem) -> ())?
}
