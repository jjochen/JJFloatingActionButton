# JJFloatingActionButton
Floating Action Button for iOS

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![License](https://img.shields.io/cocoapods/l/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![Platform](https://img.shields.io/cocoapods/p/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![Build Status](https://travis-ci.org/jjochen/JJFloatingActionButton.svg?branch=master)](https://travis-ci.org/jjochen/JJFloatingActionButton)

## Preview
<img src="./Images/JJFloatingActionButton.gif" width='250' alt="Preview">

## Requirements
* iOS 9.0+
* Swift 4.0+
* Xcode 9

## Installation
### CocoaPods
```ruby
use_frameworks!
pod 'JJFloatingActionButton'
```

## Usage
### Swift
```swift
let actionButton = JJFloatingActionButton()

actionButton.addItem(title: "item 1", image: UIImage(named: "first")?.withRenderingMode(.alwaysTemplate)) { item in
  // do something
}

actionButton.addItem(title: "item 2", image: UIImage(named: "second")?.withRenderingMode(.alwaysTemplate)) { item in
self.showMessage(for: item)
  // do something
}

actionButton.addItem(title: "item 3", image: nil) { item in
self.showMessage(for: item)
  // do something
}

view.addSubview(actionButton)
actionButton.translatesAutoresizingMaskIntoConstraints = false
actionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
```

## License

Photo Stickers is available under the MIT license. See the LICENSE file for more info.
