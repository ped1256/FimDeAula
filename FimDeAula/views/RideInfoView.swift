//
//  RideInfoView.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 22/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

protocol RideInfoViewDelegate {
    func closeButtonDidTouch()
}

class RideInfoView: UIView {
    
    let imageView = UIImageView()
    let modalView = UIView()
    let modalHeaderBackground = UIView()
    let rideTitleView = UIView()
    let driverNameText = UILabel()
    let driverImageView = UIImageView()
    let phoneIcon = UIImageView()
    let sendMessageIcon = UIImageView()
    let closeButton = UIButton()
    let rideSpaceInfoView = UIView()
    var delegate: RideInfoViewDelegate?
    
    func buildUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        buildModalLayout()
        buildRideTitleView()
        builDriverImageView()
        buildContatsInfo()
        buildDriverName()
        buildRideSpaceInfoView()
    }
    
    func buildModalLayout() {
        self.addSubview(modalView)
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        modalView.heightAnchor.constraint(equalToConstant: 408).isActive = true
        modalView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        

        modalView.addSubview(modalHeaderBackground)
        modalHeaderBackground.translatesAutoresizingMaskIntoConstraints = false
        modalHeaderBackground.leftAnchor.constraint(equalTo: modalView.leftAnchor).isActive = true
        modalHeaderBackground.rightAnchor.constraint(equalTo: modalView.rightAnchor).isActive = true
        modalHeaderBackground.topAnchor.constraint(equalTo: modalView.topAnchor).isActive = true
        modalHeaderBackground.heightAnchor.constraint(equalToConstant: 137).isActive = true
        modalHeaderBackground.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        modalHeaderBackground.layer.cornerRadius = 10
        modalHeaderBackground.clipsToBounds = true
        
        let modalHeaderBorderView = UIView()
        modalView.addSubview(modalHeaderBorderView)
        modalHeaderBorderView.translatesAutoresizingMaskIntoConstraints = false
        modalHeaderBorderView.leftAnchor.constraint(equalTo: modalView.leftAnchor).isActive = true
        modalHeaderBorderView.rightAnchor.constraint(equalTo: modalView.rightAnchor).isActive = true
        modalHeaderBorderView.bottomAnchor.constraint(equalTo: modalHeaderBackground.bottomAnchor, constant: 3).isActive = true
        modalHeaderBorderView.heightAnchor.constraint(equalToConstant: 43).isActive = true
        modalHeaderBorderView.layer.borderColor = #colorLiteral(red: 0.368627451, green: 0.368627451, blue: 0.368627451, alpha: 1)
        modalHeaderBorderView.layer.borderWidth = 2
        modalHeaderBorderView.layer.cornerRadius = 10
        modalHeaderBorderView.clipsToBounds = true
        
        // move the gray view to front
        modalView.addSubview(modalHeaderBackground)
        
        
    }
    
    func buildRideTitleView() {
        self.modalView.addSubview(rideTitleView)
        rideTitleView.translatesAutoresizingMaskIntoConstraints = false
        
        rideTitleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rideTitleView.widthAnchor.constraint(equalToConstant: 255).isActive = true
        rideTitleView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        rideTitleView.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20).isActive = true
        rideTitleView.layer.cornerRadius = 7
        rideTitleView.clipsToBounds = true
        rideTitleView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        
        let rideText = UILabel()
        rideTitleView.addSubview(rideText)
        rideText.translatesAutoresizingMaskIntoConstraints = false
        rideText.centerXAnchor.constraint(equalTo: rideTitleView.centerXAnchor).isActive = true
        rideText.centerYAnchor.constraint(equalTo: rideTitleView.centerYAnchor).isActive = true
        rideText.leftAnchor.constraint(equalTo: self.rideTitleView.leftAnchor).isActive = true
        rideText.rightAnchor.constraint(equalTo: self.rideTitleView.rightAnchor).isActive = true
        rideText.numberOfLines = 0
        rideText.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        rideText.textAlignment = .center
        rideText.text = "TICAN - terminal de integração de canasvieiras"
        rideText.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    func builDriverImageView(){
        self.modalView.addSubview(driverImageView)
        driverImageView.translatesAutoresizingMaskIntoConstraints = false
        driverImageView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        driverImageView.widthAnchor.constraint(equalToConstant: 124).isActive = true
        driverImageView.centerYAnchor.constraint(equalTo: modalHeaderBackground.bottomAnchor).isActive = true
        driverImageView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        driverImageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        driverImageView.layer.borderWidth = 2
        driverImageView.layer.borderColor = #colorLiteral(red: 0.368627451, green: 0.368627451, blue: 0.368627451, alpha: 1)
        driverImageView.clipsToBounds = true
        driverImageView.layer.cornerRadius = 62
    }
    
    func buildContatsInfo(){
        modalView.addSubview(phoneIcon)
        
        phoneIcon.translatesAutoresizingMaskIntoConstraints = false
        phoneIcon.heightAnchor.constraint(equalToConstant: 23).isActive = true
        phoneIcon.widthAnchor.constraint(equalToConstant: 23).isActive = true
        phoneIcon.leftAnchor.constraint(equalTo: rideTitleView.leftAnchor).isActive = true
        phoneIcon.bottomAnchor.constraint(equalTo: modalHeaderBackground.bottomAnchor, constant: -20).isActive = true
        phoneIcon.image = #imageLiteral(resourceName: "phoneIcon1")
        
        modalView.addSubview(sendMessageIcon)
        sendMessageIcon.translatesAutoresizingMaskIntoConstraints = false
        sendMessageIcon.heightAnchor.constraint(equalToConstant: 33).isActive = true
        sendMessageIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        sendMessageIcon.bottomAnchor.constraint(equalTo: modalHeaderBackground.bottomAnchor, constant: -15).isActive = true
        sendMessageIcon.rightAnchor.constraint(equalTo: rideTitleView.rightAnchor).isActive = true
        sendMessageIcon.image = #imageLiteral(resourceName: "messageIcon")
    }
    
    func buildDriverName() {
        self.modalView.addSubview(driverNameText)
        driverNameText.translatesAutoresizingMaskIntoConstraints = false
        driverNameText.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        driverNameText.topAnchor.constraint(equalTo: driverImageView.bottomAnchor, constant: 20).isActive = true
        driverNameText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        driverNameText.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        driverNameText.textAlignment = .center
        driverNameText.textColor = #colorLiteral(red: 0.2705882353, green: 0.2549019608, blue: 0.2549019608, alpha: 1)
        driverNameText.text = "Pedro Emanuel Skaaf"
        
    }
    
    func buildRideSpaceInfoView() {
        self.modalView.addSubview(rideSpaceInfoView)
        rideSpaceInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        rideSpaceInfoView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rideSpaceInfoView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        rideSpaceInfoView.topAnchor.constraint(equalTo: driverNameText.bottomAnchor, constant: 30).isActive = true
        rideSpaceInfoView.rightAnchor.constraint(equalTo: modalView.centerXAnchor, constant: -15).isActive = true
        rideSpaceInfoView.layer.cornerRadius = 7
        rideSpaceInfoView.clipsToBounds = true
        rideSpaceInfoView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        
        let rideSpaceInfoText = UILabel()
        
    }
    
    @objc func closeButtonAction(_ sender: Any){
        
    }
}
