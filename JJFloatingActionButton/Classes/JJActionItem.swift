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

@objc open class JJActionItem: UIControl {

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

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension JJActionItem {
    open override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            self.circleView.isHighlighted = newValue
        }
        get {
            return super.isHighlighted
        }
    }
}

fileprivate extension JJActionItem {
    func setup() {
        backgroundColor = .clear
        isUserInteractionEnabled = true
        addTarget(self, action: #selector(itemWasTapped), for: .touchUpInside)

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

    @objc func itemWasTapped() {
        delegate?.actionItemWasTapped(self)
    }
}
