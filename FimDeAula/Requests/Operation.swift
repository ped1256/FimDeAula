//
//  Operation.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 21/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class Operation: NSObject {
    func retrieverUserFacebookInfo(completion: @escaping (User)-> ()){
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, gender, cover, picture"])
        _ = graphRequest?.start(completionHandler: {
            (connection, result, error) -> Void in
            
            guard error == nil else { return }
            UserDefaults.standard.setValue(true, forKey: Identifier().userIsLogedIdentifier)
            guard let user = User.parseInfoFromFacebook(result: result) else { return }
            completion(user)
        })
    }
    
    func scheduleRide(schedule: Schedule){
        
    }
}
