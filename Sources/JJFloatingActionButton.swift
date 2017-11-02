
import UIKit
import SnapKit


public enum JJFloatingActionButtonState {
    case close
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


@objc public class JJFloatingActionButton: UIView {
    
    @objc public var buttonColor = UIColor(red: 0.447, green: 0.769, blue: 0.447, alpha: 1.000) {
        didSet {
            buttonView.circleColor = buttonColor
        }
    }
    
    @objc public var buttonIconColor = UIColor.white {
        didSet {
            buttonView.iconColor = buttonIconColor
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
    
    @objc public var itemColor = UIColor.white {
        didSet {
            
        }
    }
    
    @objc public var itemIconColor = UIColor(red: 0.447, green: 0.769, blue: 0.447, alpha: 1.000) {
        didSet {
            
        }
    }
    
    @objc public var itemTitleColor = UIColor.white {
        didSet {
            
        }
    }
    
    @objc public var itemShadowColor = UIColor.black {
        didSet {
            
        }
    }
    
    @objc public var itemShadowOffset = CGSize(width: 0, height: 1) {
        didSet {
            
        }
    }
    
    @objc public var itemShadowOpacity = Float(0.4) {
        didSet {
            
        }
    }
    
    @objc public var itemShadowRadius = CGFloat(2) {
        didSet {
            
        }
    }
    
    @objc public var overlayColor = UIColor(white: 0, alpha: 0.5) {
        didSet {
            overlayView.backgroundColor = overlayColor
        }
    }
    
    @objc public var rotationAngle = -CGFloat.pi / 4
    
    @objc public var animationDuration = TimeInterval(0.3)
    
    @objc public var items: [JJActionItem] = [] {
        didSet {
            configure()
        }
    }
    
    @objc public var delegate: JJFloatingActionButtonDelegate?
    
    fileprivate(set) public var state: JJFloatingActionButtonState = .close
    
    fileprivate lazy var buttonView: JJCircleImageView = {
        let view = JJCircleImageView()
        view.circleColor = self.buttonColor
        view.iconColor = self.buttonIconColor
        view.layer.shadowColor = self.shadowColor.cgColor
        view.layer.shadowOffset = self.shadowOffset
        view.layer.shadowOpacity = self.shadowOpacity
        view.layer.shadowRadius = self.shadowRadius
        return view
    }()
    
    fileprivate lazy var overlayView: UIControl = {
        let view = UIControl()
        view.backgroundColor = self.overlayColor
        view.addTarget(self, action: #selector(overlayViewWasTapped), for: .touchUpInside)
        view.isUserInteractionEnabled = true
        view.isEnabled = false
        view.alpha = 0
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: Touches
fileprivate extension JJFloatingActionButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard touches.count == 1 else {
            return
        }
        guard let touch = touches.first else {
            return
        }
        let point = touch.location(in: self)
        guard bounds.contains(point) else {
            return
        }
        
        didTap()
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if state == .open {
            for item in items {
                if item.isHidden || !item.isUserInteractionEnabled {
                    continue
                }
                let pointInItem = item.convert(point, from: self)
                if item.bounds.contains(pointInItem)  {
                    return item.hitTest(pointInItem, with: event)
                }
            }
        }
        return super.hitTest(point, with: event)
    }
    
    @objc func overlayViewWasTapped() {
        close()
    }
}

fileprivate extension JJFloatingActionButton {
    
    func setup() {
        backgroundColor = UIColor.clear
        clipsToBounds = false
        
        addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(buttonView.snp.height)
            make.size.lessThanOrEqualTo(self)
            make.size.equalTo(self).priority(.high)
        }
        
        configure()
    }
    
    func configure() {
        buttonView.image = currentButtonIcon
        items.forEach { item in
            item.circleView.circleColor = self.itemColor
            item.circleView.iconColor = self.itemIconColor
            item.titleLabel.textColor = self.itemTitleColor
            item.layer.shadowColor = self.itemShadowColor.cgColor
            item.layer.shadowOpacity = self.itemShadowOpacity
            item.layer.shadowOffset = self.itemShadowOffset
            item.layer.shadowRadius = self.itemShadowRadius
            item.delegate = self
        }
    }
    
    var currentButtonIcon: UIImage? {
        var image: UIImage? = nil
        
        if items.count == 1 {
            image = items.first?.icon
        }
        
        if image == nil {
            image = defaultButtonIcon
        }
        
        return image
    }
    
    var defaultButtonIcon: UIImage? {
        let frameworkBundle = Bundle(for: JJFloatingActionButton.self)
        guard let resourceBundleURL = frameworkBundle.url(forResource: "JJFloatingActionButton", withExtension: "bundle") else {
            return nil
        }
        let resourceBundle = Bundle(url: resourceBundleURL)
        let image = UIImage(named: "Plus", in: resourceBundle, compatibleWith: nil)
        return image
    }
    
    func didTap() {
        let itemsCount = items.count
        if itemsCount == 0 {
            return
        }
        
        if itemsCount == 1 {
            let item = items.first
            item?.action?(item!)
            return
        }
        
        if state == .close {
            open()
        } else if state == .open {
            close()
        }
        
    }
    
    func open(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let superview = self.superview else {
            return
        }
        state = .opening
        delegate?.floatingActionButtonWillOpen?(self)
        overlayView.isEnabled = true
        
        superview.bringSubview(toFront: self)
        superview.insertSubview(overlayView, belowSubview: buttonView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalTo(superview)
        }
        
        var previousItem: JJActionItem?
        for item in items {
            if item.isHidden {
                continue
            }
            item.alpha = 0
            insertSubview(item, belowSubview: buttonView)
            item.snp.makeConstraints { make in
                let previousView = previousItem ?? buttonView
                make.height.equalTo(buttonView).multipliedBy(0.75)
                make.bottom.equalTo(previousView.snp.top).offset(-12)
            }
            item.circleView.snp.makeConstraints { make in
                make.centerX.equalTo(buttonView)
            }
            previousItem = item
        }
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let animations: () -> Void = {
            self.overlayView.alpha = 1
            self.buttonView.transform = CGAffineTransform(rotationAngle: self.rotationAngle)
            self.items.forEach { item in
                item.alpha = 1
            }
        }
        let animationCompletion: (Bool) -> Void = { finished in
            self.state = .open
            self.delegate?.floatingActionButtonDidOpen?(self)
            completion?()
        }
        
        self.animate(usingSpringWithDamping: 0.55,
                     initialSpringVelocity: 0.3,
                     animations: animations,
                     completion: animationCompletion,
                     animated: animated)
    }
    
    func close(animated: Bool = true, completion: (() -> Void)? = nil) {
        state = .closing
        delegate?.floatingActionButtonWillClose?(self)
        overlayView.isEnabled = false
        
        let animations: () -> Void = {
            self.overlayView.alpha = 0
            self.buttonView.transform = CGAffineTransform(rotationAngle: 0)
            self.items.forEach { item in
                item.alpha = 0
            }
        }
        let animationCompletion: (Bool) -> Void = { finished in
            self.overlayView.removeFromSuperview()
            self.items.forEach { item in
                item.removeFromSuperview()
            }
            self.state = .close
            self.delegate?.floatingActionButtonDidClose?(self)
            completion?()
        }
        
        self.animate(usingSpringWithDamping: 0.6,
                     initialSpringVelocity: 0.8,
                     animations: animations,
                     completion: animationCompletion,
                     animated: animated)
    }
    
    func animate(usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIViewAnimationOptions = [.beginFromCurrentState], animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           usingSpringWithDamping: dampingRatio,
                           initialSpringVelocity: velocity,
                           animations: animations,
                           completion: completion)
        } else {
            animations()
            if let completion = completion {
                completion(true)
            }
        }
    }
}

extension JJFloatingActionButton: JJActionItemDelegate {
    func actionButtonWasTapped(_ item: JJActionItem) {
        close()
        item.action?(item)
    }
}
