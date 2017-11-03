//
//  JJActionItem.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 30.10.17.
//

import UIKit

internal protocol JJActionItemDelegate {
    func actionButtonWasTapped(_ item: JJActionItem)
}

@objc open class JJActionItem: UIView {
    
    @objc open var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    @objc open var image: UIImage? {
        didSet {
            self.circleView.image = image
        }
    }
    
    @objc open var action: ((JJActionItem) -> ())?
    
    fileprivate(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = self.title
        titleLabel.numberOfLines = 1
        return titleLabel
    } ()
    
    fileprivate(set) lazy var circleView: JJCircleImageView = {
        let view = JJCircleImageView()
        view.image = self.image
        return view
    }()
    
    internal var delegate: JJActionItemDelegate?
    
    fileprivate var isSingleTouchInside = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

fileprivate extension JJActionItem {
    func setup() {
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = true
        
        addSubview(titleLabel)
        addSubview(circleView)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        circleView.snp.makeConstraints { make in
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(circleView.snp.height)
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
        }
    }
}

// MARK: Touches
fileprivate extension JJActionItem {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateHighlightedStateForTouches(touches)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        updateHighlightedStateForTouches(touches)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        circleView.isHighlighted = false
        if touchesAreTapInside(touches)
        {
            delegate?.actionButtonWasTapped(self)
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        circleView.isHighlighted = false
    }
    
    func updateHighlightedStateForTouches(_ touches: Set<UITouch>) {
        circleView.isHighlighted = touchesAreTapInside(touches)
    }
    
    func touchesAreTapInside(_ touches: Set<UITouch>) -> Bool {
        guard touches.count == 1 else {
            return false
        }
        guard let touch = touches.first else {
            return false
        }
        let point = touch.location(in: self)
        guard bounds.contains(point) else {
            return false
        }
        
        return true
    }
}
