//
//  PUKeyboardFollowingButtonController.swift
//  CartKit
//
//  Created by Guilherme Rambo on 05/04/19.
//

import UIKit

public class PUKeyboardFollowingButtonController: UIViewController {

    public var actionTitle: String? {
        didSet {
            updateButton()
        }
    }

    public init(actionTitle: String?) {
        self.actionTitle = actionTitle

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("LOL NO")
    }

    public var accessoryController: UIViewController? {
        didSet {
            guard oldValue != self.accessoryController else { return }

            guard let accessory = self.accessoryController else {
                oldValue?.view.removeFromSuperview()
                oldValue?.removeFromParentViewController()
                oldValue?.didMove(toParentViewController: nil)
                return
            }

            installAccessory(accessory)
        }
    }

    public var buttonTapHandler: (() -> Void)?
    public var keyboardWillShowAnimationCompanion: (() -> Void)?
    public var keyboardWillHideAnimationCompanion: (() -> Void)?

    public var tapOutsideHandler: (() -> Void)?

    public var buttonHeight: CGFloat {
        return actionButton.intrinsicContentSize.height
    }

    public var autodismissesKeyboard = false

    public lazy var actionButton: PUCartHugeActionButton = {
        let b = PUCartHugeActionButton(frame: .zero)

        b.sizeToFit()
        b.setTitle(actionTitle, for: .normal)
        b.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false

        return b
    }()

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [])

        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.spacing = 0

        return v
    }()

    @objc private func buttonAction(_ sender: PUCartHugeActionButton) {
        buttonTapHandler?()
    }

    public func install(in container: UIViewController) {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = container.view.bounds
        container.view.addSubview(view)
        container.addChildViewController(self)
        didMove(toParentViewController: container)
    }

    public override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)

        if parent != nil { installContents() }
    }

    // MARK: - Layout

    private lazy var touchTransparentView = PUTouchTransparentView()

    public override func loadView() {
        view = touchTransparentView
        view.backgroundColor = .clear
        view.isOpaque = false

        touchTransparentView.negativeAreaTapHandler = { [weak self] in
            self?.tapOutsideHandler?()
            self?.tappedOutside()
        }
    }

    private func tappedOutside() {
        guard autodismissesKeyboard else { return }

        parent?.view.endEditing(true)
    }

    private lazy var contentBottomConstraint: NSLayoutConstraint = {
        return actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }()

    private func installContents() {
        guard actionButton.superview == nil else { return }

        updateButton()

        view.addSubview(actionButton)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            contentBottomConstraint,
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: actionButton.topAnchor)
        ])

        installKeyboardObservers()
    }

    private func updateButton() {
        if actionTitle != nil {
            actionButton.setTitle(actionTitle, for: .normal)
            actionButton.isHidden = false
        } else {
            actionButton.isHidden = true
        }
    }

    // MARK: - Keyboard

    private func installKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }

    private var parentIsAtTheTopOfTheNavigationStack: Bool {
        return parent?.view.window != nil
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard !isBeingDismissed else { return }

        guard var animator = KeyboardAnimationHelper(notification) else { return }

        if isBeingPresented {
            animator.duration = 0
        }

        animator.animateAlongsideKeyboard { [weak self] in
            guard let self = self else { return }

            // We don't want to animate showing the keyboard if this controller's parent is not
            // the top view controller in the navigation stack (if there is one),
            // otherwise there will be an unintended raise of the button which looks weird
            guard self.parentIsAtTheTopOfTheNavigationStack else { return }

            let extraOffset: CGFloat

            if #available(iOS 11.0, *) {
                extraOffset = view.safeAreaInsets.bottom
            } else {
                extraOffset = 0
            }

            self.keyboardWillShowAnimationCompanion?()

            if #available(iOS 11.0, *) {
                self.actionButton.overrideSafeAreaInsets = nil
            }

            self.contentBottomConstraint.constant = -animator.frame.height + extraOffset
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let animator = KeyboardAnimationHelper(notification) else { return }

        animator.animateAlongsideKeyboard { [weak self] in
            guard let self = self else { return }

            if #available(iOS 11.0, *) {
                self.actionButton.overrideSafeAreaInsets = view.safeAreaInsets
            }

            self.keyboardWillHideAnimationCompanion?()
            self.contentBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }

    private func installAccessory(_ accessory: UIViewController) {
        addChildViewController(accessory)
        stackView.insertArrangedSubview(accessory.view, at: 0)
        accessory.didMove(toParentViewController: self)
    }

}

/// This view will not accept touches on itself, only its subviews
fileprivate final class PUTouchTransparentView: UIView {

    var negativeAreaTapHandler: (() -> Void)?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, with: event)

        if result != self {
            return result
        } else {
            negativeAreaTapHandler?()
            return nil
        }
    }

}
