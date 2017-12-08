# JJFloatingActionButton
Floating Action Button for iOS

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![License](https://img.shields.io/cocoapods/l/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![Platform](https://img.shields.io/cocoapods/p/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![Build Status](https://circleci.com/gh/jjochen/JJFloatingActionButton.svg?style=shield)](https://circleci.com/gh/jjochen/JJFloatingActionButton)
[![codecov](https://codecov.io/gh/jjochen/JJFloatingActionButton/branch/master/graph/badge.svg)](https://codecov.io/gh/jjochen/JJFloatingActionButton)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/jjochen/JJFloatingActionButton/issues)


## Preview
<img src="https://github.com/jjochen/JJFloatingActionButton/raw/master/Images/JJFloatingActionButton.gif" width='250' alt="Preview">

## Requirements
* iOS 9.0+
* Swift 4.0+
* Xcode 9

## Installation
### CocoaPods

JJFloatingActionButton is available through [CocoaPods](http://cocoapods.org).
To install it, simply add the following line to your Podfile:

```ruby
pod 'JJFloatingActionButton'
```


## Usage

```swift
let actionButton = JJFloatingActionButton()

actionButton.addItem(title: "item 1", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate)) { item in
  // do something
}

actionButton.addItem(title: "item 2", image: UIImage(named: "Second")?.withRenderingMode(.alwaysTemplate)) { item in
  // do something
}

actionButton.addItem(title: "item 3", image: nil) { item in
  // do something
}

view.addSubview(actionButton)
actionButton.translatesAutoresizingMaskIntoConstraints = false
actionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
```

### Configuration
```swift
var buttonColor: UIColor
var defaultButtonImage: UIImage?
var openButtonImage: UIImage?
var buttonImageColor: UIColor
var shadowColor: UIColor
var shadowOffset: CGSize
var shadowOpacity: Float
var shadowRadius: CGFloat
var overlayColor: UIColor
var itemTitleFont: UIFont
var itemButtonColor: UIColor
var itemImageColor: UIColor
var itemTitleColor: UIColor
var itemShadowColor: UIColor
var itemShadowOffset: CGSize
var itemShadowOpacity: Float
var itemShadowRadius: CGFloat
var itemSizeRatio: CGFloat
var interItemSpacing: CGFloat
var rotationAngle: CGFloat
```

### Delegate
```swift
optional func floatingActionButtonWillOpen(_ button: JJFloatingActionButton)
optional func floatingActionButtonDidOpen(_ button: JJFloatingActionButton)
optional func floatingActionButtonWillClose(_ button: JJFloatingActionButton)
optional func floatingActionButtonDidClose(_ button: JJFloatingActionButton)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Jochen Pfeiffer, pod@jochen-pfeiffer.com

## License

JJFloatingActionButton is available under the MIT license. See the LICENSE file for more info.
