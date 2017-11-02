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
    
    @objc open var icon: UIImage? {
        didSet {
            self.circleView.image = icon
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
        view.image = self.icon
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
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        circleView.snp.makeConstraints { make in
            make.trailing.equalTo(self)
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
        updateTouches(touches)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        updateTouches(touches)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        
        delegate?.actionButtonWasTapped(self)
    }
    
    func updateTouches(_ touches: Set<UITouch>) {
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
    
        circleView.isHighlighted = true
    }
    
}
