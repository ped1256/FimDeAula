//
//  KeyboardAnimationHelper.swift
//  CartKit
//
//  Created by Guilherme Rambo on 05/04/19.
//

import UIKit

public struct KeyboardAnimationHelper {

    public var duration: TimeInterval
    public let curve: UIView.AnimationCurve
    public let frame: CGRect

    public init?(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return nil }
        guard let frameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return nil }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return nil }
        guard let rawCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int else { return nil }
        guard let curve = UIView.AnimationCurve(rawValue: rawCurve) else { return nil }

        self.frame = frameValue.cgRectValue
        self.duration = duration
        self.curve = curve
    }

    public func animateAlongsideKeyboard(_ block: () -> ()) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(self.curve)
        UIView.setAnimationDuration(self.duration)

        block()
        
        UIView.commitAnimations()
    }

}
