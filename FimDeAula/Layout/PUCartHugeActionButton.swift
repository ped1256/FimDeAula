//
//  PUCartHugeActionButton.swift
//  PeixeUrbano
//
//  Created by Guilherme Rambo on 26/01/17.
//
//

import UIKit

open class PUCartHugeActionButton: UIButton {

    private struct Metrics {
        static let usableHeight: CGFloat = 50
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    open override var isEnabled: Bool {
        didSet {
            guard isEnabled != oldValue else { return }
            guard isEnabled == false else {
                updateUI()
                return
            }
            
            self.backgroundColor = .gray
            self.titleLabel?.textColor = .gray
        }
    }

    open override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else { return }

            let highlightOpacity: Float = isHighlighted ? 1 : 0

            UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .allowAnimatedContent, .allowUserInteraction], animations: {
                self.highlightLayer.opacity = highlightOpacity
            }, completion: nil)
        }
    }

    private lazy var highlightLayer: CALayer = {
        let l = CALayer()

        l.opacity = 0
        l.frame = self.layer.bounds
        l.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor

        return l
    }()
    
    private func setup() {
        updateUI()
        layer.addSublayer(highlightLayer)
    }
    
    private func updateUI(){
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        backgroundColor = ThemeColor.shared.actionButtonColor
        titleLabel?.textColor = ThemeColor.shared.secondaryTextColor
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setAnimationDuration(0)
        CATransaction.setDisableActions(true)
        highlightLayer.frame = bounds
        CATransaction.commit()
    }

    open override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let original = super.titleRect(forContentRect: contentRect)

        let halfUsableHeight = Metrics.usableHeight / 2

        return CGRect(x: bounds.width / 2 - original.width / 2,
                      y: halfUsableHeight - original.height / 2,
                      width: original.width,
                      height: original.height)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()

        invalidateIntrinsicContentSize()
    }

    var overrideSafeAreaInsets: UIEdgeInsets? {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    @available(iOS 11.0, *)
    var effectiveSafeAreaInsets: UIEdgeInsets {
        return overrideSafeAreaInsets ?? superview?.safeAreaInsets ?? .zero
    }

    @available(iOS 11.0, *)
    open override func safeAreaInsetsDidChange() {
        super.safeAreaInsetsDidChange()

        invalidateIntrinsicContentSize()
    }
    
    open override var intrinsicContentSize: CGSize {
        let inset: CGFloat

        if #available(iOS 11.0, *) {
            inset = effectiveSafeAreaInsets.bottom
        } else {
            inset = 0
        }

        return CGSize(width: super.intrinsicContentSize.width, height: Metrics.usableHeight + inset)
    }

}
