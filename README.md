# JJFloatingActionButton
Floating Action Button for iOS

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![License](https://img.shields.io/cocoapods/l/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![Platform](https://img.shields.io/cocoapods/p/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton)
[![Build Status](https://circleci.com/gh/jjochen/JJFloatingActionButton.svg?style=shield)](https://circleci.com/gh/jjochen/JJFloatingActionButton)
[![codecov](https://codecov.io/gh/jjochen/JJFloatingActionButton/branch/master/graph/badge.svg)](https://codecov.io/gh/jjochen/JJFloatingActionButton)
[![Documentation](https://jjochen.github.io/JJFloatingActionButton/badge.svg)](https://jjochen.github.io/JJFloatingActionButton)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/jjochen/JJFloatingActionButton/issues)


<p align="center">
  <a href="#preview">Preview</a> • <a href="#features">Features</a> • <a href="#requirements">Requirements</a> • <a href="#installation">Installation</a> • <a href="#usage">Usage</a> • <a href="#author">Author</a> • <a href="#license">License</a>
</p>


## Preview

<p align="center">
  <img src="https://github.com/jjochen/JJFloatingActionButton/raw/master/Images/JJFloatingActionButton.gif" width='250' alt="Preview">
</p>

## Features

- Easy to use  ✓
- Fully customizable  ✓
- Handles Buttons with single Action  ✓
- Works in Swift and Objective-C Projects  ✓
- Comprehensive Test Coverage  ✓
- [Complete Documentation](https://jjochen.github.io/JJFloatingActionButton)  ✓


## Requirements

- iOS 9.0+
- Xcode 9.0+
- Swift 4.0+


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate JJFloatingActionButton into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'JJFloatingActionButton'
end
```

Then, run the following command:

```bash
$ pod install
```

### Manually

If you prefer not to use a dependency manager, you can integrate JJFloatingActionButton into your project manually.


## Usage

### Quick Start

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
actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
```

### Configuration

Button appearance and behavior can be customized:

```swift
var buttonColor: UIColor
var defaultButtonImage: UIImage?
var openButtonImage: UIImage?
var buttonImageColor: UIColor
var shadowColor: UIColor
var shadowOffset: CGSize
var shadowOpacity: Float
var shadowRadius: CGFloat

var interItemSpacing: CGFloat
var rotationAngle: CGFloat

var itemTitleFont: UIFont
var itemButtonColor: UIColor
var itemImageColor: UIColor
var itemTitleColor: UIColor
var itemShadowColor: UIColor
var itemShadowOffset: CGSize
var itemShadowOpacity: Float
var itemShadowRadius: CGFloat
var itemSizeRatio: CGFloat
```

### Delegate

```swift
optional func floatingActionButtonWillOpen(_ button: JJFloatingActionButton)
optional func floatingActionButtonDidOpen(_ button: JJFloatingActionButton)
optional func floatingActionButtonWillClose(_ button: JJFloatingActionButton)
optional func floatingActionButtonDidClose(_ button: JJFloatingActionButton)
```

### Example

To run the example project, just run the following command:

```bash
$ pod try JJFloatingActionButton
```

### Resources

- [Documentation](https://jjochen.github.io/JJFloatingActionButton/)


## Author

Jochen Pfeiffer [https://github.com/jjochen](https://github.com/jjochen)


## License

JJFloatingActionButton is available under the MIT license. See the LICENSE file for more info.
