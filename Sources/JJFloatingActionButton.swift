
import UIKit
import SnapKit

@objc open class JJFloatingActionButton: UIView {
    
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
    
    @objc public var overlayColor = UIColor(white: 0, alpha: 0.5) {
        didSet {
            overlayView.backgroundColor = overlayColor
        }
    }
    
    @objc public var rotateOnOpen = true
    
    @objc public var items: [JJActionItem] = [] {
        didSet {
            configure()
        }
    }
    
    fileprivate(set) public var isOpen = false
    
    fileprivate lazy var buttonView: JJCircleImageView = {
        let view = JJCircleImageView()
        view.circleColor = self.buttonColor
        view.iconColor = self.buttonIconColor
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
    
fileprivate extension JJFloatingActionButton {

    // MARK: Touches
    
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
        isOpen = true
        
        insertSubview(overlayView, belowSubview: buttonView)
        overlayView.snp.makeConstraints { make in
            make.edges.equalTo(superview)
        }
        
        let animations: () -> Void = {
            self.overlayView.alpha = 1
        }
        
        animate(animations, animated: animated)
        
    }
    
    func close(animated: Bool = true) {
        isOpen = false
        
        let animations: () -> Void = {
            self.overlayView.alpha = 0
        }
        let completion: (Bool) -> Void = { finished in
            self.overlayView.removeFromSuperview()
        }
        
        animate(animations, completion: completion, animated: animated)
    }
    
    func animate(_ animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)? = nil, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.beginFromCurrentState, .curveEaseOut],
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
