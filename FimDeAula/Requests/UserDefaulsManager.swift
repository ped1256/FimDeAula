//
//  UserDefaulsManager.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 03/06/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation
class UserDefaultsManager: NSObject {

    static let defaults = UserDefaults.standard
    
    static func saveAuth() {
        defaults.set(true, forKey: Identifier().userIsAuthenticatedIdentifier)
    }
    
    static func saveLogin() {
        defaults.set(true, forKey: Identifier().userIsloged)
    }
    
    static func saveFirstTime() {
        defaults.set(true, forKey: Identifier().userFirstTimeIdentifier)
    }
    
    static func logOutUser() {
        defaults.set(false, forKey: Identifier().userIsAuthenticatedIdentifier)
        defaults.set(true, forKey: Identifier().userIsloged)
    }
}
