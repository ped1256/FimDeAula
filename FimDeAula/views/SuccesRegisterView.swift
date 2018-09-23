//
//  SuccesRegisterView.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 22/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class SuccesRegisterView: UIView {
    
    let imageView = UIImageView()
    let modalView = UIView()
    let messagetext = UILabel()
    let confirmButton = UIButton()
    
    func buildUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        self.addSubview(modalView)
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        modalView.heightAnchor.constraint(equalToConstant: 327).isActive = true
        modalView.widthAnchor.constraint(equalToConstant: 327).isActive = true
        
    }
}
