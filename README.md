# JJFloatingActionButton
Floating Action Button for iOS

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg) [![Version](https://img.shields.io/cocoapods/v/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton) [![License](https://img.shields.io/cocoapods/l/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton) [![Platform](https://img.shields.io/cocoapods/p/JJFloatingActionButton.svg?style=flat)](https://cocoapods.org/pods/JJFloatingActionButton) [![Build Status](https://circleci.com/gh/jjochen/JJFloatingActionButton.svg?style=shield)](https://circleci.com/gh/jjochen/JJFloatingActionButton) [![codecov](https://codecov.io/gh/jjochen/JJFloatingActionButton/branch/master/graph/badge.svg)](https://codecov.io/gh/jjochen/JJFloatingActionButton) [![Documentation](https://jjochen.github.io/JJFloatingActionButton/badge.svg)](https://jjochen.github.io/JJFloatingActionButton) [![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/jjochen/JJFloatingActionButton/issues)

Until reaching milestone 1.0.0 there might be breaking changes in minor versions!

<p align="center">
  <a href="#features">Features</a> • <a href="#preview">Preview</a> • <a href="#requirements">Requirements</a> • <a href="#installation">Installation</a> • <a href="#usage">Usage</a> • <a href="#author">Author</a> • <a href="#license">License</a>
</p>


## <a name="features"></a>Features

- Easy to use  ✓
- Fully customizable  ✓
- Place with auto layout  ✓
- Design in Interface Builder  ✓
- RTL language support
- Handles Button with single Action  ✓
- Works in Swift and Objective-C Projects  ✓
- Comprehensive Test Coverage  ✓
- [Complete Documentation](https://jjochen.github.io/JJFloatingActionButton)  ✓


## <a name="preview"></a>Preview

<p align="center">
  <img src="https://github.com/jjochen/JJFloatingActionButton/raw/master/Images/JJFloatingActionButtonBasics.gif" width='250' alt="Preview Basics"> 
  <img src="https://github.com/jjochen/JJFloatingActionButton/raw/master/Images/JJFloatingActionButtonConfiguration.gif" width='250' alt="Preview Configuration"> 
</p>
<p align="center">
  <img src="https://github.com/jjochen/JJFloatingActionButton/raw/master/Images/JJFloatingActionButtonCircularPop.gif" width='250' alt="Preview Circular Pop"> 
  <img src="https://github.com/jjochen/JJFloatingActionButton/raw/master/Images/JJFloatingActionButtonSingleItem.gif" width='250' alt="Preview Single Item">
</p>


## <a name="requirements"></a>Requirements

- iOS 9.0+
- Xcode 9.0+
- Swift 4.0+


## <a name="installation"></a>Installation

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


## <a name="usage"></a>Usage

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
actionButton.overlayView.backgroundColor = UIColor(hue: 0.31, saturation: 0.37, brightness: 0.10, alpha: 0.30)
actionButton.buttonImage = UIImage(named: "Dots")
actionButton.buttonColor = .red
actionButton.buttonImageColor = .white

actionButton.buttonOpeningStyle = .transition(image: UIImage(named: "X"))
actionButton.itemOpeningStyle = .popUp(interItemSpacing: 14)

actionButton.layer.shadowColor = UIColor.black.cgColor
actionButton.layer.shadowOffset = CGSize(width: 0, height: 1)
actionButton.layer.shadowOpacity = Float(0.4)
actionButton.layer.shadowRadius = CGFloat(2)

actionButton.itemSizeRatio = CGFloat(0.75)
actionButton.configureDefaultItem { item in
    item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
    item.titleLabel.textColor = .white
    item.buttonColor = .white
    item.buttonImageColor = .red

    item.layer.shadowColor = UIColor.black.cgColor
    item.layer.shadowOffset = CGSize(width: 0, height: 1)
    item.layer.shadowOpacity = Float(0.4)
    item.layer.shadowRadius = CGFloat(2)
}

actionButton.addItem(title: "Balloon", image: UIImage(named: "Baloon")) { item in
    // Do something
}

let item = actionButton.addItem()
item.titleLabel.text = "Owl"
item.imageView.image = UIImage(named: "Owl")
item.buttonColor = .black
item.buttonImageColor = .white
tem.action = { item in
    // Do something
}
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


## <a name="author"></a>Author

Jochen Pfeiffer [https://github.com/jjochen](https://github.com/jjochen)


## <a name="license"></a>License

JJFloatingActionButton is available under the MIT license. See the LICENSE file for more info.
