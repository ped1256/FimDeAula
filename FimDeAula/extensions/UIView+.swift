//
//  UIView+.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 11/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func modalStyle(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = ThemeColor.shared.modalBackgroundColor
        self.alpha = 0.7
    }
    
    func makeBlurImage(targetImageView: UIView, style: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        targetImageView.addSubview(blurEffectView)
    }
}
