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
        self.layer.cornerRadius = 40
        self.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        self.alpha = 0.7
    }
}
