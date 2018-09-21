//
//  User.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 20/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    var name: String
    var id: String
    var email: String?
    var picture: UIImage?
    var picturePath: String?{
        didSet {
            parseImage()
        }
    }

    var schedules = [Schedule]()
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }

    static func parseInfoFromFacebook(result: Any) -> User? {
        guard let result = result as? [String: AnyObject],
        let id = result["id"] as? String,
        let name = result["name"] as? String,
        let picture = result["picture"] as? [String: Any],
        let imageData = picture["data"] as? [String: Any],
        let imageURL = imageData["url"] as? String else { return nil  }
        
        let user = User(name: name, id: id)
        user.picturePath = imageURL
        return user
    }
    
    func parseImage(){
        guard let path = self.picturePath, let url = URL(string: path) else { return }
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let imageData = data else { return  }
            let image = UIImage(data: imageData)
            self.picture = image
        }.resume()
    }
}
