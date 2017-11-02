
import UIKit
import SnapKit


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
    
    @objc public var itemTextColor = UIColor.white {
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
    
    
    fileprivate(set) public var isOpen = false
    
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
    
    fileprivate lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = self.overlayColor
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
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
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
            executeAction(at: 0)
            return
        }
        
        if isOpen {
            close()
        } else {
            open()
        }
    }
    
    func open(animated: Bool = true) {
        guard let superview = self.superview else {
            return
        }
        delegate?.floatingActionButtonWillOpen?(self)
        isOpen = true
        
        insertSubview(overlayView, belowSubview: buttonView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalTo(superview)
        }
        
        let animations: () -> Void = {
            self.overlayView.alpha = 1
            self.buttonView.transform = CGAffineTransform(rotationAngle: self.rotationAngle)
        }
        let completion: (Bool) -> Void = { finished in
            self.delegate?.floatingActionButtonDidOpen?(self)
        }
        
        self.animate(usingSpringWithDamping: 0.55,
                     initialSpringVelocity: 0.3,
                     animations: animations,
                     completion: completion,
                     animated: animated)
    }
    
    func close(animated: Bool = true) {
        delegate?.floatingActionButtonWillClose?(self)
        isOpen = false
        
        let animations: () -> Void = {
            self.overlayView.alpha = 0
            self.buttonView.transform = CGAffineTransform(rotationAngle: 0)
        }
        let completion: (Bool) -> Void = { finished in
            self.overlayView.removeFromSuperview()
            self.delegate?.floatingActionButtonDidClose?(self)
        }
        
        self.animate(usingSpringWithDamping: 0.6,
                     initialSpringVelocity: 0.8,
                     animations: animations,
                     completion: completion,
                     animated: animated)
    }
    
    func animate(usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIViewAnimationOptions = [.beginFromCurrentState], animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)? = nil, animated: Bool = true) {
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
    
    
    func executeAction(at index: Int) {
        guard index >= 0 && index < items.count else {
            return
        }
        let item = items[index]
        executeAction(for: item)
    }
    
    func executeAction(for item: JJActionItem) {
        guard let action = item.action else {
            return
        }
        
        action(item)
    }
}
