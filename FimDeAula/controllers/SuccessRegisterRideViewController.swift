//
//  SuccessRegisterRideViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 22/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class SuccessRegisterRideView: UIView {
    
    var modalView = UIView()
    var successImageView = UIImageView()

    func buildUI() {
        self.addSubview(modalView)
        
        modalView.backgroundColor = .white
        
        modalView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        modalView.heightAnchor.constraint(equalToConstant: 326).isActive = true
        modalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        modalView.addSubview(successImageView)
        successImageView.heightAnchor.constraint(equalToConstant: 146).isActive = true
        successImageView.widthAnchor.constraint(equalToConstant: 146).isActive = true
        successImageView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        successImageView.image = #imageLiteral(resourceName: "successRegisterIcon")
        
    }
    
}
