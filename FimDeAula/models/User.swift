//
//  User.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 20/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class User: NSObject {
    var name: String
    var id: String
    var email: String?
    var picture: UIImage?
    var phoneNumber: String = ""
    var picturePath: String?

    var schedules = [Schedule]()
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }

    
    static func parseInfoFromFacebook(result: Any, completion: @escaping (User) -> ()){
        guard let result = result as? [String: AnyObject],
            let id = result["id"] as? String,
            let name = result["name"] as? String,
            let picture = result["picture"] as? [String: Any],
            let imageData = picture["data"] as? [String: Any] else { return }
        
        let user = User(name: name, id: id)
        user.picturePath = "http://graph.facebook.com/\(user.id)/picture?type=large"
        user.parseImage {
            completion(user)
        }
    }
    
    func parseImage(completion: @escaping () -> ()){
        guard let path = self.picturePath, let url = URL(string: path) else { return }
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let imageData = data else { return  }
            let image = UIImage(data: imageData)
            self.picture = image
            completion()
        }.resume()
    }
}
