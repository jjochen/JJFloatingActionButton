//
//  JJFloatingActionButton.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 30.10.17.
//  Copyright © 2017 Jochen Pfeiffer. All rights reserved.
//

import UIKit

/// A floating action button.
///
/// ### Example ###
///   ````
///   let actionButton = JJFloatingActionButton()
///
///   actionButton.addItem(title: "item 1", image: image1) { item in
///       // do something
///   }
///
///   actionButton.addItem(title: "item 2", image: image2) { item in
///       // do something
///   }
///
///   view.addSubview(actionButton)
///   ````
///
@objc @IBDesignable public class JJFloatingActionButton: UIControl {

    /// The delegate object for the floating action button.
    ///
    @objc public weak var delegate: JJFloatingActionButtonDelegate?

    /// The list of action items.
    /// Default is `[]`.
    ///
    @objc public var items: [JJActionItem] = [] {
        didSet {
            items.forEach { item in
                configureItem(item)
            }
            configureButtonImage()
        }
    }

    /// The background color of the floating action button.
    /// Default is `UIColor(hue: 0.31, saturation: 0.37, brightness: 0.76, alpha: 1.00)`.
    ///
    @objc @IBInspectable public var buttonColor: UIColor = .defaultButtonColor {
        didSet {
            circleView.color = buttonColor
        }
    }

    /// The background color of the floating action button with highlighted state.
    /// Default is `nil`.
    ///
    @objc @IBInspectable public var highlightedButtonColor: UIColor? {
        didSet {
            circleView.highlightedColor = highlightedButtonColor
        }
    }

    /// The image displayed on the button by default.
    /// When only one `JJActionItem` is added and `handleSingleActionDirectly` is enabled,
    /// the image from the item is shown istead.
    /// When an `openButtonImage` is given this is shwon when the button is opened.
    /// Default is `nil`.
    ///
    /// - SeeAlso: `openButtonImage`
    ///
    @objc @IBInspectable public var defaultButtonImage: UIImage? {
        didSet {
            configureButtonImage()
        }
    }

    /// The image that is displayed when the button is opened.
    /// Default is `nil`.
    ///
    /// - Warning: When `openButtonImage` is set, `rotationAngle` is ignored
    ///            and the button will not rotate when opening.
    ///
    /// - SeeAlso: `rotationAngle`
    ///
    @objc @IBInspectable public var openButtonImage: UIImage? {
        didSet {
            configureButtonImage()
        }
    }

    /// The tint color of the image view.
    /// Default is `UIColor.white`.
    ///
    /// - Warning: Only template images are colored.
    ///
    @objc @IBInspectable public var buttonImageColor: UIColor = .white {
        didSet {
            imageView.tintColor = buttonImageColor
        }
    }

    /// The shadow color of the floating action button.
    /// Default is `UIColor.black`.
    ///
    @objc @IBInspectable public var shadowColor: UIColor = .black {
        didSet {
            circleView.layer.shadowColor = shadowColor.cgColor
        }
    }

    /// The shadow offset of the floating action button.
    /// Default is `CGSize(width: 0, height: 1)`.
    ///
    @objc @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 1) {
        didSet {
            circleView.layer.shadowOffset = shadowOffset
        }
    }

    /// The shadow opacity of the floating action button.
    /// Default is `0.4`.
    ///
    @objc @IBInspectable public var shadowOpacity: Float = 0.4 {
        didSet {
            circleView.layer.shadowOpacity = shadowOpacity
        }
    }

    /// The shadow radius of the floating action button.
    /// Default is `2`.
    ///
    @objc @IBInspectable public var shadowRadius: CGFloat = 2 {
        didSet {
            circleView.layer.shadowRadius = shadowRadius
        }
    }

    /// The color of the overlay.
    /// Default is `UIColor(white: 0, alpha: 0.5)`.
    ///
    @objc @IBInspectable public var overlayColor: UIColor = UIColor(white: 0, alpha: 0.5) {
        didSet {
            overlayView.backgroundColor = overlayColor
        }
    }

    /// The default title font of an action item.
    /// Default is `UIFont.systemFont(ofSize: UIFont.systemFontSize)`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc public var itemTitleFont: UIFont = .systemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            items.forEach { item in
                item.titleLabel.font = itemTitleFont
            }
        }
    }

    /// The default color of an action item.
    /// Default is `UIColor.white`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var itemButtonColor: UIColor = .white {
        didSet {
            items.forEach { item in
                item.circleView.color = itemButtonColor
            }
        }
    }

    /// The default highlighted color of an action item.
    /// Default is `nil`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var highlightedItemButtonColor: UIColor? {
        didSet {
            items.forEach { item in
                item.circleView.highlightedColor = highlightedItemButtonColor
            }
        }
    }

    /// The default image tint color of an action item.
    /// If none is given, the color of the floating action button is used.
    /// Default is `nil`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var itemImageColor: UIColor? {
        didSet {
            items.forEach { item in
                item.imageView.tintColor = currentItemButtonColor
            }
        }
    }

    /// The default title color of an action item.
    /// Default is `UIColor.white`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var itemTitleColor: UIColor = .white {
        didSet {
            items.forEach { item in
                item.titleLabel.textColor = itemTitleColor
            }
        }
    }

    /// The default shadow color of an action item.
    /// Default is `UIColor.black`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var itemShadowColor: UIColor = .black {
        didSet {
            items.forEach { item in
                item.layer.shadowColor = itemShadowColor.cgColor
            }
        }
    }

    /// The default shadow offset of an action item.
    /// Default is `CGSize(width: 0, height: 1)`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var itemShadowOffset: CGSize = CGSize(width: 0, height: 1) {
        didSet {
            items.forEach { item in
                item.layer.shadowOffset = itemShadowOffset
            }
        }
    }

    /// The default shadow opacity of an action item.
    /// Default is `0.4`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var itemShadowOpacity: Float = 0.4 {
        didSet {
            items.forEach { item in
                item.layer.shadowOpacity = itemShadowOpacity
            }
        }
    }

    /// The default shadow radius of an action item.
    /// Default is `2`.
    ///
    /// - Remark: This can be changed for each action item.
    ///
    @objc @IBInspectable public var itemShadowRadius: CGFloat = 2 {
        didSet {
            items.forEach { item in
                item.layer.shadowRadius = itemShadowRadius
            }
        }
    }

    /// The size of an action item in relation to the floating action button.
    /// Default is `0.75`.
    ///
    @objc @IBInspectable public var itemSizeRatio: CGFloat = 0.75

    /// The space between two action items in points.
    /// Default is `12`.
    ///
    @objc @IBInspectable public var interItemSpacing: CGFloat = 12

    /// The angle in radians the button should rotate when opening.
    /// Default is `-CGFloat.pi / 4`.
    ///
    /// - Warning: When `openButtonImage` is set, `rotationAngle` is ignored and the button will not rotate when opening.
    ///
    /// - SeeAlso: `openButtonImage`
    ///
    @objc @IBInspectable public var rotationAngle: CGFloat = -.pi / 4

    /// When enabled and only one action item is added, the floating action button will not open,
    /// but the action from the action item will be executed direclty when the button is tapped.
    /// Also the image of the floating action button will be replaced with the one from the action item.
    ///
    /// Default is `true`.
    ///
    @objc @IBInspectable public var handleSingleActionDirectly: Bool = true {
        didSet {
            configureButtonImage()
        }
    }

    /// The current state of the floating action button.
    /// Possible values are
    ///   - `.opening`
    ///   - `.open`
    ///   - `.closing`
    ///   - `.closed`
    ///
    @objc public fileprivate(set) var buttonState: JJFloatingActionButtonState = .closed

    /// The round background view of the floating action button.
    /// Read only.
    ///
    @objc open fileprivate(set) lazy var circleView: JJCircleView = lazyCircleView()

    /// The image view of the floating action button.
    /// Read only.
    ///
    @objc open fileprivate(set) lazy var imageView: UIImageView = lazyImageView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    internal lazy var overlayView: UIControl = lazyOverlayView()

    internal lazy var itemContainerView: UIView = lazyItemContainer()

    fileprivate var buttonAnimation: JJButtonAnimation?

    fileprivate var itemAnimation: JJItemAnimation?
}

// MARK: - Lazy UI Elements

fileprivate extension JJFloatingActionButton {

    func lazyCircleView() -> JJCircleView {
        let view = JJCircleView()
        view.isUserInteractionEnabled = false
        view.color = buttonColor
        view.highlightedColor = highlightedButtonColor
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowRadius = shadowRadius
        return view
    }

    func lazyImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.tintColor = buttonImageColor
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }

    func lazyOverlayView() -> UIControl {
        let control = UIControl()
        control.isUserInteractionEnabled = true
        control.backgroundColor = overlayColor
        control.addTarget(self, action: #selector(overlayViewWasTapped), for: .touchUpInside)
        control.isEnabled = false
        control.alpha = 0
        return control
    }

    func lazyItemContainer() -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

// MARK: - Public Methods

public extension JJFloatingActionButton {

    /// Add an action item with title, image and action to the list of items.
    /// The item will be pre configured with the default values.
    ///
    /// - Parameter title: The title of the action item. Default is `nil`.
    /// - Parameter image: The image of the action item. Default is `nil`.
    /// - Parameter action: The action handler of the action item. Default is `nil`.
    ///
    /// - Returns: The item that was added. This can be configured after it has been added.
    ///
    @objc @discardableResult func addItem(title: String? = nil,
                                          image: UIImage? = nil,
                                          action: ((JJActionItem) -> Void)? = nil) -> JJActionItem {
        let item = JJActionItem()
        item.titleLabel.text = title
        item.imageView.image = image
        item.action = action

        addItem(item)

        return item
    }

    /// Add an action item to the list of items.
    /// The item will be updated with the default configuration values.
    ///
    /// - Parameter item: The action item.
    ///
    /// - Returns: The item that was add. Its configuration can be changed after it has been added.
    ///
    @objc func addItem(_ item: JJActionItem) {
        items.append(item)
        configureItem(item)
        configureButtonImage()
    }

    /// Open the floating action button and show all action items.
    ///
    /// - Parameter animated: When true, button will be opened with an animation. Default is `true`.
    /// - Parameter completion: Will be handled upon completion. Default is `nil`.
    ///
    @objc func open(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard buttonState == .closed else {
            return
        }
        guard let superview = superview else {
            return
        }
        guard !items.isEmpty else {
            return
        }
        guard !isSingleActionButton else {
            return
        }

        buttonState = .opening
        delegate?.floatingActionButtonWillOpen?(self)

        buttonAnimation = currentButtonAnimation
        itemAnimation = currentItemAnimation

        superview.bringSubview(toFront: self)
        addOverlayView(to: superview)
        superview.insertSubview(itemContainerView, belowSubview: self)
        itemAnimation?.addItems(to: itemContainerView)
        itemContainerView.setNeedsLayout()
        itemContainerView.layoutIfNeeded()

        let animationGroup = DispatchGroup()

        showOverlay(animated: animated, group: animationGroup)
        buttonAnimation?.open(animated: animated, group: animationGroup)
        itemAnimation?.open(animated: animated, group: animationGroup)

        let groupCompletion: () -> Void = {
            self.buttonState = .open
            self.delegate?.floatingActionButtonDidOpen?(self)
            completion?()
        }
        if animated {
            animationGroup.notify(queue: .main, execute: groupCompletion)
        } else {
            groupCompletion()
        }
    }

    /// Close the floating action button and hide all action items.
    ///
    /// - Parameter animated: When true, button will be close with an animation. Default is `true`.
    /// - Parameter completion: Will be handled upon completion. Default is `nil`.
    ///
    @objc func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard buttonState == .open else {
            return
        }
        buttonState = .closing
        delegate?.floatingActionButtonWillClose?(self)
        overlayView.isEnabled = false

        let animationGroup = DispatchGroup()

        hideOverlay(animated: animated, group: animationGroup)
        buttonAnimation?.close(animated: animated, group: animationGroup)
        itemAnimation?.close(animated: animated, group: animationGroup)

        let groupCompletion: () -> Void = {
            self.itemAnimation?.removeItems()
            self.itemAnimation = nil
            self.itemContainerView.removeFromSuperview()
            self.buttonAnimation = nil
            self.buttonState = .closed
            self.delegate?.floatingActionButtonDidClose?(self)
            completion?()
        }
        if animated {
            animationGroup.notify(queue: .main, execute: groupCompletion)
        } else {
            groupCompletion()
        }
    }
}

// MARK: - UIControl

extension JJFloatingActionButton {
    open override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            circleView.isHighlighted = newValue
        }
        get {
            return super.isHighlighted
        }
    }
}

// MARK: - UIView

extension JJFloatingActionButton {
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: 56, height: 56)
    }
}

// MARK: - Configuration

fileprivate extension JJFloatingActionButton {
    func setup() {
        backgroundColor = UIColor.clear
        clipsToBounds = false
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)

        addSubview(circleView)
        addSubview(imageView)

        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor).isActive = true
        circleView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor).isActive = true
        circleView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor).isActive = true
        let widthConstraint = circleView.widthAnchor.constraint(equalTo: widthAnchor)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        let heightConstraint = circleView.heightAnchor.constraint(equalTo: heightAnchor)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        let imageSizeMuliplier = CGFloat(1 / sqrt(2))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: circleView.widthAnchor, multiplier: imageSizeMuliplier).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualTo: circleView.heightAnchor, multiplier: imageSizeMuliplier).isActive = true

        configureButtonImage()
    }

    func configureItem(_ item: JJActionItem) {
        item.circleView.color = itemButtonColor
        item.circleView.highlightedColor = highlightedItemButtonColor
        item.imageView.tintColor = currentItemButtonColor
        item.titleLabel.font = itemTitleFont
        item.titleLabel.textColor = itemTitleColor
        item.layer.shadowColor = itemShadowColor.cgColor
        item.layer.shadowOpacity = itemShadowOpacity
        item.layer.shadowOffset = itemShadowOffset
        item.layer.shadowRadius = itemShadowRadius
        item.addTarget(self, action: #selector(itemWasTapped(sender:)), for: .touchUpInside)
    }

    var currentItemButtonColor: UIColor {
        return itemImageColor ?? buttonColor
    }

    func configureButtonImage() {
        imageView.image = currentButtonImage
    }

    var currentButtonImage: UIImage? {
        if isSingleActionButton, let image = items.first?.imageView.image {
            return image
        }

        if defaultButtonImage == nil {
            defaultButtonImage = defaultButtonImageResource
        }

        return defaultButtonImage
    }

    var defaultButtonImageResource: UIImage? {
        let resourceBundle = Bundle.assetsBundle()
        let image = UIImage(named: "Plus", in: resourceBundle, compatibleWith: nil)
        return image
    }

    var isSingleActionButton: Bool {
        return handleSingleActionDirectly && items.count == 1
    }
}

// MARK: - Animation

fileprivate extension JJFloatingActionButton {

    func addOverlayView(to superview: UIView) {
        overlayView.isEnabled = true
        superview.insertSubview(overlayView, belowSubview: self)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        overlayView.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        overlayView.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }

    func showOverlay(animated: Bool, group: DispatchGroup) {
        let buttonAnimation: () -> Void = {
            self.overlayView.alpha = 1
        }
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.3,
                       animations: buttonAnimation,
                       group: group,
                       animated: animated)
    }

    func hideOverlay(animated: Bool, group: DispatchGroup) {
        let animations: () -> Void = {
            self.overlayView.alpha = 0
        }
        let completion: (Bool) -> Void = { _ in
            self.overlayView.removeFromSuperview()
        }
        UIView.animate(duration: 0.3,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.8,
                       animations: animations,
                       completion: completion,
                       group: group,
                       animated: animated)
    }

    var currentButtonAnimation: JJButtonAnimation {
        let buttonAnimation: JJButtonAnimation
        if let openImage = openButtonImage {
            buttonAnimation = JJButtonTransitionAnimation(actionButton: self,
                                                          openImage: openImage,
                                                          closeImage: currentButtonImage)
        } else {
            buttonAnimation = JJButtonRotationAnimation(actionButton: self,
                                                        angle: rotationAngle)
        }

        return buttonAnimation
    }

    var currentItemAnimation: JJItemAnimation {
        let itemAnimation: JJItemAnimation
        itemAnimation = JJItemPopAnimation(actionButton: self,
                                           items: enabledItems,
                                           itemSizeRatio: itemSizeRatio,
                                           interItemSpacing: interItemSpacing)

        return itemAnimation
    }

    var enabledItems: [JJActionItem] {
        return items.filter { item -> Bool in
            return !item.isHidden && item.isUserInteractionEnabled
        }
    }
}

// MARK: - Actions

fileprivate extension JJFloatingActionButton {

    @objc func buttonWasTapped() {
        switch buttonState {
        case .open:
            close()

        case .closed:
            handleSingleActionOrOpen()

        default:
            break
        }
    }

    @objc func itemWasTapped(sender: JJActionItem) {
        close {
            sender.action?(sender)
        }
    }

    @objc func overlayViewWasTapped() {
        close()
    }

    func handleSingleActionOrOpen() {
        guard !items.isEmpty else {
            return
        }

        if isSingleActionButton {
            let item = items.first
            item?.action?(item!)
        } else {
            open()
        }
    }
}
