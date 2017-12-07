//
//  JJActionItem.swift
//  JJFloatingActionButton
//
//  Created by Jochen on 30.10.17.
//

import UIKit

@objc @IBDesignable open class JJActionItem: UIControl {

    @objc open var action: ((JJActionItem) -> Void)?

    @objc open fileprivate(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.isUserInteractionEnabled = false
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    @objc open fileprivate(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()

    @objc open fileprivate(set) lazy var circleView: JJCircleView = {
        let view = JJCircleView()
        view.isUserInteractionEnabled = false
        return view
    }()

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
            circleView.isHighlighted = newValue
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

        addSubview(titleLabel)
        addSubview(circleView)
        addSubview(imageView)

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

        let imageSizeMuliplier = CGFloat(1 / sqrt(2))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualTo: circleView.widthAnchor, multiplier: imageSizeMuliplier).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualTo: circleView.heightAnchor, multiplier: imageSizeMuliplier).isActive = true
    }
}
