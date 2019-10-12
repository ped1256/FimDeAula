//
//  AuthenticationProvider.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 07/10/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import FirebaseAuth

class AuthenticationEmailManager {
    static func auth(email: String, password: String, completion: @escaping (AuthDataResult?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(result)
        }
    }
    
    static func register(email: String, password: String, completion: @escaping (AuthDataResult?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(result)
        }
    }
}
