//
//  BackgroundViewWithAnimate.swift
//  desafios
//
//  Created by Pedro Emanuel on 05/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit
import Foundation

class BackgroundViewWithAnimate: UIView {

    var backView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backView)
        backView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: 1000, height: 1000)
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "cesuscBackgroundImage"))
        imageView.frame = backView.frame
        
        backView.addSubview(imageView)
        
        startbackGroundAnimate()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startbackGroundAnimate(){
        UIView.animate(withDuration: 15.0, animations: {
            self.backView.frame = CGRect(x: self.frame.origin.x - self.frame.width, y: self.frame.origin.y - 40, width: self.frame.width + self.frame.width, height: self.frame.height)
            
        }) { finished in
            UIView.animate(withDuration: 15.0, animations: {
                self.backView.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width + self.frame.width, height: self.frame.height)
            }, completion: { finished in
                self.startbackGroundAnimate()
            })
        }
    }
}
