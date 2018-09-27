//
//  Utilitys.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 26/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class App: NSObject {
    func isIphoneSE() -> Bool {
        let screenRect = UIScreen.main.bounds
        if screenRect.size.height == 568 {
            return true
        } else {
            return false
        }
    }
    
    func isIphoneX() -> Bool {
        let screen = UIScreen.main.bounds
        if screen.size.height >= 812 {
            return true
        } else {
            return false
        }
    }
}
