
import UIKit

@objc public enum JJFloatingActionButtonState: Int {
    case closed
    case open
    case opening
    case closing
}

@objc public protocol JJFloatingActionButtonDelegate {
    @objc optional func floatingActionButtonWillOpen(_ button: JJFloatingActionButton)
    @objc optional func floatingActionButtonDidOpen(_ button: JJFloatingActionButton)
    @objc optional func floatingActionButtonWillClose(_ button: JJFloatingActionButton)
    @objc optional func floatingActionButtonDidClose(_ button: JJFloatingActionButton)
}

@objc public class JJFloatingActionButton: UIControl {

    @objc public var delegate: JJFloatingActionButtonDelegate?

    @objc public var items: [JJActionItem] = [] {
        didSet {
            items.forEach { item in
                configureItem(item)
            }
            configureButton()
        }
    }

    @objc public var buttonColor = UIColor.defaultButtonColor {
        didSet {
            buttonView.circleColor = buttonColor
        }
    }

    @objc public var defaultButtonImage: UIImage? {
        didSet {
            configureButton()
        }
    }

    @objc public var openButtonImage: UIImage? {
        didSet {
            configureButton()
        }
    }

    @objc public var buttonImageColor = UIColor.white {
        didSet {
            buttonView.imageColor = buttonImageColor
        }
    }

    @objc public var shadowColor = UIColor.black {
        didSet {
            self.buttonView.layer.shadowColor = shadowColor.cgColor
        }
    }

    @objc public var shadowOffset = CGSize(width: 0, height: 1) {
        didSet {
            self.buttonView.layer.shadowOffset = shadowOffset
        }
    }

    @objc public var shadowOpacity = Float(0.4) {
        didSet {
            self.buttonView.layer.shadowOpacity = shadowOpacity
        }
    }

    @objc public var shadowRadius = CGFloat(2) {
        didSet {
            self.buttonView.layer.shadowRadius = shadowRadius
        }
    }

    @objc public var overlayColor = UIColor(white: 0, alpha: 0.5) {
        didSet {
            overlayView.backgroundColor = overlayColor
        }
    }

    @objc public var itemTitleFont = UIFont.systemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            items.forEach { item in
                item.titleLabel.font = itemTitleFont
            }
        }
    }

    @objc public var itemButtonColor = UIColor.white {
        didSet {
            items.forEach { item in
                item.circleView.circleColor = itemButtonColor
            }
        }
    }

    @objc public var itemImageColor = UIColor.defaultButtonColor {
        didSet {
            items.forEach { item in
                item.circleView.imageColor = itemImageColor
            }
        }
    }

    @objc public var itemTitleColor = UIColor.white {
        didSet {
            items.forEach { item in
                item.titleLabel.textColor = itemTitleColor
            }
        }
    }

    @objc public var itemShadowColor = UIColor.black {
        didSet {
            items.forEach { item in
                item.layer.shadowColor = itemShadowColor.cgColor
            }
        }
    }

    @objc public var itemShadowOffset = CGSize(width: 0, height: 1) {
        didSet {
            items.forEach { item in
                item.layer.shadowOffset = itemShadowOffset
            }
        }
    }

    @objc public var itemShadowOpacity = Float(0.4) {
        didSet {
            items.forEach { item in
                item.layer.shadowOpacity = itemShadowOpacity
            }
        }
    }

    @objc public var itemShadowRadius = CGFloat(2) {
        didSet {
            items.forEach { item in
                item.layer.shadowRadius = itemShadowRadius
            }
        }
    }

    @objc public var itemSizeRatio = CGFloat(0.75)

    @objc public var interItemSpacing = CGFloat(12)

    @objc public var rotationAngle = -CGFloat.pi / 4

    @objc public fileprivate(set) var buttonState: JJFloatingActionButtonState = .closed

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    internal lazy var buttonView: JJCircleImageView = defaultButtonView()

    internal lazy var overlayView: UIControl = defaultOverlayView()

    internal var openItems: [JJActionItem]?
}

public extension JJFloatingActionButton {
    @objc @discardableResult public func addItem(title: String? = nil, image: UIImage? = nil, action: ((JJActionItem) -> Void)? = nil) -> JJActionItem {
        let item = JJActionItem()
        item.title = title
        item.image = image
        item.action = action

        items.append(item)
        configureItem(item)
        configureButton()

        return item
    }

    @objc public func open(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard buttonState == .closed else {
            return
        }
        guard let superview = superview else {
            return
        }
        guard items.count > 1 else {
            return
        }
        buttonState = .opening
        delegate?.floatingActionButtonWillOpen?(self)
        overlayView.isEnabled = true

        configureButton()

        superview.bringSubview(toFront: self)
        superview.insertSubview(overlayView, belowSubview: self)

        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        overlayView.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        overlayView.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true

        var previousItem: JJActionItem?
        for item in items {
            let previousView = previousItem ?? buttonView
            item.alpha = 0
            item.transform = .identity
            superview.insertSubview(item, belowSubview: self)

            item.translatesAutoresizingMaskIntoConstraints = false
            item.heightAnchor.constraint(equalTo: buttonView.heightAnchor, multiplier: itemSizeRatio).isActive = true
            item.bottomAnchor.constraint(equalTo: previousView.topAnchor, constant: -interItemSpacing).isActive = true
            item.circleView.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true

            previousItem = item
        }
        openItems = items

        setNeedsLayout()
        layoutIfNeeded()

        let animationGroup = DispatchGroup()

        let buttonAnimation: () -> Void = {
            self.overlayView.alpha = 1
            self.buttonView.imageView.transform = CGAffineTransform(rotationAngle: self.rotationAngle)
        }
        animate(duration: 0.3,
                usingSpringWithDamping: 0.55,
                initialSpringVelocity: 0.3,
                animations: buttonAnimation,
                group: animationGroup,
                animated: animated)

        var delay = 0.0
        for item in items {
            shrink(item)
            let itemAnimation: () -> Void = {
                item.transform = .identity
                item.alpha = 1
            }
            animate(duration: 0.3,
                    delay: delay,
                    usingSpringWithDamping: 0.55,
                    initialSpringVelocity: 0.3,
                    animations: itemAnimation,
                    group: animationGroup,
                    animated: animated)

            delay += 0.1
        }

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

    @objc public func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard buttonState == .open else {
            return
        }
        buttonState = .closing
        delegate?.floatingActionButtonWillClose?(self)
        overlayView.isEnabled = false

        configureButton()

        let animationGroup = DispatchGroup()

        let buttonAnimations: () -> Void = {
            self.overlayView.alpha = 0
            self.buttonView.imageView.transform = CGAffineTransform(rotationAngle: 0)
        }
        let buttonAnimationCompletion: (Bool) -> Void = { _ in
            self.overlayView.removeFromSuperview()
        }
        animate(duration: 0.3,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.8,
                animations: buttonAnimations,
                completion: buttonAnimationCompletion,
                group: animationGroup,
                animated: animated)

        var delay = 0.0
        for item in items.reversed() {
            let itemAnimation: () -> Void = {
                self.shrink(item)
                item.alpha = 0
            }
            let itemAnimationCompletion: (Bool) -> Void = { _ in
                item.removeFromSuperview()
            }
            animate(duration: 0.15,
                    delay: delay,
                    usingSpringWithDamping: 0.6,
                    initialSpringVelocity: 0.8,
                    animations: itemAnimation,
                    completion: itemAnimationCompletion,
                    group: animationGroup,
                    animated: animated)

            delay += 0.1
        }

        let groupCompletion: () -> Void = {
            self.openItems = nil
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

extension JJFloatingActionButton {
    open override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            self.buttonView.isHighlighted = newValue
        }
        get {
            return super.isHighlighted
        }
    }
}

extension JJFloatingActionButton {
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 56, height: 56)
    }
}

fileprivate extension JJFloatingActionButton {
    func setup() {
        backgroundColor = UIColor.clear
        clipsToBounds = false
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)

        addSubview(buttonView)

        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonView.widthAnchor.constraint(equalTo: buttonView.heightAnchor).isActive = true
        buttonView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor).isActive = true
        buttonView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor).isActive = true
        let widthConstraint = buttonView.widthAnchor.constraint(equalTo: widthAnchor)
        widthConstraint.priority = .defaultHigh
        widthConstraint.isActive = true
        let heightConstraint = buttonView.heightAnchor.constraint(equalTo: heightAnchor)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        configureButton()
    }

    func defaultButtonView() -> JJCircleImageView {
        let view = JJCircleImageView()
        view.circleColor = buttonColor
        view.imageColor = buttonImageColor
        view.layer.shadowColor = shadowColor.cgColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowRadius = shadowRadius
        return view
    }

    func defaultOverlayView() -> UIControl {
        let control = UIControl()
        control.backgroundColor = overlayColor
        control.addTarget(self, action: #selector(overlayViewWasTapped), for: .touchUpInside)
        control.isUserInteractionEnabled = true
        control.isEnabled = false
        control.alpha = 0
        return control
    }

    func configureItem(_ item: JJActionItem) {
        item.circleView.circleColor = itemButtonColor
        item.circleView.imageColor = itemImageColor
        item.titleLabel.font = itemTitleFont
        item.titleLabel.textColor = itemTitleColor
        item.layer.shadowColor = itemShadowColor.cgColor
        item.layer.shadowOpacity = itemShadowOpacity
        item.layer.shadowOffset = itemShadowOffset
        item.layer.shadowRadius = itemShadowRadius
        item.delegate = self
    }

    func configureButton() {
        buttonView.image = currentButtonImage
    }

    var currentButtonImage: UIImage? {
        let useFirstItemImage = (items.count == 1)
        if useFirstItemImage, let image = items.first?.image {
            return image
        }

        let useOpenButtonImage = (buttonState == .opening || buttonState == .open)
        if useOpenButtonImage, let image = openButtonImage {
            return image
        }

        if defaultButtonImage == nil {
            defaultButtonImage = defaultButtonImageResource
        }
        return defaultButtonImage
    }

    var defaultButtonImageResource: UIImage? {
        let frameworkBundle = Bundle(for: JJFloatingActionButton.self)
        guard let resourceBundleURL = frameworkBundle.url(forResource: "JJFloatingActionButton", withExtension: "bundle") else {
            return nil
        }
        let resourceBundle = Bundle(url: resourceBundleURL)
        let image = UIImage(named: "Plus", in: resourceBundle, compatibleWith: nil)
        return image
    }

    func animate(duration: TimeInterval, delay: TimeInterval = 0, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options _: UIViewAnimationOptions = [.beginFromCurrentState], animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil, group: DispatchGroup? = nil, animated: Bool = true) {

        let groupedAnimations: () -> Void = {
            group?.enter()
            animations()
        }
        let groupedCompletion: (Bool) -> Void = { finished in
            completion?(finished)
            group?.leave()
        }

        if animated {
            UIView.animate(withDuration: duration,
                           delay: delay,
                           usingSpringWithDamping: dampingRatio,
                           initialSpringVelocity: velocity,
                           animations: groupedAnimations,
                           completion: groupedCompletion)
        } else {
            groupedAnimations()
            groupedCompletion(true)
        }
    }

    func shrink(_ item: JJActionItem) {
        let scaleFactor = CGFloat(0.4)
        let itemWidth = item.frame.width
        let itemCircleWidth = item.circleView.frame.width
        let translationX = (itemWidth - itemCircleWidth) * (1 - scaleFactor) / 2
        let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        let translation = CGAffineTransform(translationX: translationX, y: 0)
        let transform = scale.concatenating(translation)
        item.transform = transform
    }

    @objc func buttonWasTapped() {
        switch buttonState {
        case .open:
            close()

        case .closed:
            switch items.count {
            case 0:
                break

            case 1:
                let item = items.first
                item?.action?(item!)

            default:
                open()
            }

        default:
            break
        }
    }

    @objc func overlayViewWasTapped() {
        close()
    }
}

extension JJFloatingActionButton: JJActionItemDelegate {
    func actionItemWasTapped(_ item: JJActionItem) {
        close {
            item.action?(item)
        }
    }
}
