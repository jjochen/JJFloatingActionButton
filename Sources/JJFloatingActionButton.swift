
import UIKit
import SnapKit

@objc open class JJFloatingActionButton: UIView {
    
    @objc public var buttonColor = UIColor(red: 0.447, green: 0.769, blue: 0.447, alpha: 1.000) {
        didSet {
            buttonView.circleColor = buttonColor
        }
    }
    
    @objc public var buttonIconColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000) {
        didSet {
            buttonView.iconColor = buttonIconColor
        }
    }
    
    
    @objc public var itemColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000) {
        didSet {
            
        }
    }
    
    @objc public var itemIconColor = UIColor(red: 0.447, green: 0.769, blue: 0.447, alpha: 1.000) {
        didSet {
            
        }
    }
    
    @objc public var itemTextColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000) {
        didSet {
            
        }
    }
    
    @objc public var rotateOnOpen = true
    
    @objc public var items: [JJActionItem] = [] {
        didSet {
            
        }
    }
    
    fileprivate(set) public var isOpen = false
    
    
    fileprivate lazy var buttonView = JJCircleImageView()
    
    
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
    
    
    open override func updateConstraints() {
        buttonView.snp.remakeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(buttonView.snp.height)
            make.size.lessThanOrEqualTo(self)
            make.size.equalTo(self).priority(.high)
        }
        
        super.updateConstraints()
    }
}
    
    
fileprivate extension JJFloatingActionButton {

    // MARK: Touches
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1 else {
            return
        }
        guard let touch = touches.first else {
            return
        }
        let point = touch.location(in: self)
        guard self.bounds.contains(point) else {
            return
        }
        
        didTap()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        
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
    
   
    
    func open() {
        isOpen = true
    }
    
    func close() {
        isOpen = false
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
