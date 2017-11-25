//
//  JJActionItem.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 30.10.17.
//

import UIKit

internal protocol JJActionItemDelegate {
    func actionItemWasTapped(_ item: JJActionItem)
}

@objc open class JJActionItem: UIView {

    @objc open var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    @objc open var image: UIImage? {
        didSet {
            circleView.image = image
        }
    }

    @objc open var action: ((JJActionItem) -> Void)?

    fileprivate(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    fileprivate(set) lazy var circleView: JJCircleImageView = {
        let view = JJCircleImageView()
        view.image = image
        return view
    }()

    internal var delegate: JJActionItemDelegate?

    fileprivate var isSingleTouchInside = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

fileprivate extension JJActionItem {
    func setup() {
        backgroundColor = .clear
        isUserInteractionEnabled = true

        addSubview(titleLabel)
        addSubview(circleView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        circleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        circleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor).isActive = true
        circleView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 12).isActive = true
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

// MARK: Touches
extension JJActionItem {
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
        if touchesAreTapInside(touches) {
            delegate?.actionItemWasTapped(self)
        }
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        circleView.isHighlighted = false
    }
}
