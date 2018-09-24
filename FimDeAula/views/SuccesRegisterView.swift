//
//  SuccesRegisterView.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 22/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

protocol SuccesRegisterViewDelegate {
    func confirmSuccessButtonDidTouch()
}

class SuccesRegisterView: UIView {
    
    let imageView = UIImageView()
    let modalView = UIView()
    let messagetext = UILabel()
    let confirmButton = UIButton()
    var delegate: SuccesRegisterViewDelegate?
    
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
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 146).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 146).isActive = true
        imageView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20).isActive = true
        
        imageView.image = #imageLiteral(resourceName: "successRegisterIcon")
        
        self.modalView.addSubview(messagetext)
        messagetext.translatesAutoresizingMaskIntoConstraints = false
        messagetext.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
        messagetext.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 20).isActive = true
        messagetext.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -20).isActive = true
        messagetext.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        messagetext.textColor = #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        messagetext.numberOfLines = 2
        messagetext.text = "Carona cadastrada com \n sucesso"
        messagetext.textAlignment = .center
        
        
        self.modalView.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 146).isActive = true
        confirmButton.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -20).isActive = true
        confirmButton.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        confirmButton.layer.cornerRadius = 8
        confirmButton.clipsToBounds = true
        confirmButton.setTitle("OK", for: .normal)
        confirmButton.setTitleColor(#colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1).withAlphaComponent(0.6), for: .normal)
        confirmButton.setTitleColor(#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), for: .highlighted)
        confirmButton.addTarget(self, action: #selector(confirmAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func confirmAction(_ sender: Any){
        delegate?.confirmSuccessButtonDidTouch()
    }
}
