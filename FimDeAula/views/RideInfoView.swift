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
    
    var user: User?
    var schedule: Schedule?
    let imageView = UIImageView()
    let modalView = UIView()
    let modalHeaderBackground = UIView()
    let rideTitleView = UIView()
    let rideText = UILabel()
    let driverNameText = UILabel()
    let driverImageView = UIImageView()
    let phoneIcon = UIButton()
    let sendMessageIcon = UIButton()
    let closeButton = UIButton()
    let rideSpaceInfoView = UIView()
    let rideSpaceInfoText = UILabel()
    let distinyInfoView = UIView()
    let distinyInfoText = UILabel()
    var delegate: RideInfoViewDelegate?
    
    func buildUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.alpha = 0.0
        
        buildModalLayout()
        buildRideTitleView()
        builDriverImageView()
        buildContatsInfo()
        buildDriverName()
        buildRideSpaceInfoView()
        buildDistinyInfo()
        buildDriverCommentView()
        buildCloseButton()
        getDriverInfo()
        
        UIView.animate(withDuration: 1.0) {
            self.alpha = 1.0
        }
    }
    
    func getDriverInfo(){
        guard let driverId = schedule?.user?.id else { return }
        Operation().getUserInfo(id: driverId ) { user in
            self.user = user
            self.updateUI()
        }
    }
    
    func buildCloseButton() {
        modalView.addSubview(closeButton)
        closeButton.setImage(#imageLiteral(resourceName: "Grey_close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: .touchUpInside)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        closeButton.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -15).isActive = true
        
        if App().isIphoneSE() {
            closeButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -20).isActive = true
        } else {
            closeButton.topAnchor.constraint(equalTo: rideTitleView.topAnchor).isActive = true
        }

        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeButtonAction(_:))))
        
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
        
        rideTitleView.addSubview(rideText)
        rideText.translatesAutoresizingMaskIntoConstraints = false
        rideText.centerXAnchor.constraint(equalTo: rideTitleView.centerXAnchor).isActive = true
        rideText.centerYAnchor.constraint(equalTo: rideTitleView.centerYAnchor).isActive = true
        rideText.leftAnchor.constraint(equalTo: self.rideTitleView.leftAnchor).isActive = true
        rideText.rightAnchor.constraint(equalTo: self.rideTitleView.rightAnchor).isActive = true
        rideText.numberOfLines = 0
        rideText.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        rideText.textAlignment = .center
        
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
        phoneIcon.setImage(#imageLiteral(resourceName: "phoneIcon1"), for: .normal)
        phoneIcon.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        
        modalView.addSubview(sendMessageIcon)
        sendMessageIcon.translatesAutoresizingMaskIntoConstraints = false
        sendMessageIcon.heightAnchor.constraint(equalToConstant: 33).isActive = true
        sendMessageIcon.widthAnchor.constraint(equalToConstant: 33).isActive = true
        sendMessageIcon.bottomAnchor.constraint(equalTo: modalHeaderBackground.bottomAnchor, constant: -15).isActive = true
        sendMessageIcon.rightAnchor.constraint(equalTo: rideTitleView.rightAnchor).isActive = true
        sendMessageIcon.setImage(#imageLiteral(resourceName: "whatsaapLogo"), for: .normal)
        sendMessageIcon.addTarget(self, action: #selector(openWhatsaap(_:)), for: .touchUpInside)
    }
    
    @objc func callAction(_ sender: Any){
        guard let user = user else { return }
        if let url = URL(string: "telprompt:\(user.phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    @objc func openWhatsaap(_ sender: Any) {
        guard let user = user else { return }
        if let url = URL(string:"https://api.whatsapp.com/send?phone=+55\(user.phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
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
        
        
        rideSpaceInfoView.addSubview(rideSpaceInfoText)
        rideSpaceInfoText.translatesAutoresizingMaskIntoConstraints = false
        rideSpaceInfoText.centerXAnchor.constraint(equalTo: rideSpaceInfoView.centerXAnchor).isActive = true
        rideSpaceInfoText.centerYAnchor.constraint(equalTo: rideSpaceInfoView.centerYAnchor).isActive = true
        rideSpaceInfoText.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        rideSpaceInfoText.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        rideSpaceInfoText.textAlignment = .center
    }
    
    func buildDistinyInfo() {
        self.modalView.addSubview(distinyInfoView)
        distinyInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        distinyInfoView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        distinyInfoView.widthAnchor.constraint(equalToConstant: 113).isActive = true
        distinyInfoView.topAnchor.constraint(equalTo: driverNameText.bottomAnchor, constant: 30).isActive = true
        distinyInfoView.leftAnchor.constraint(equalTo: modalView.centerXAnchor, constant: 15).isActive = true
        distinyInfoView.layer.cornerRadius = 7
        distinyInfoView.clipsToBounds = true
        distinyInfoView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        
        distinyInfoView.addSubview(distinyInfoText)
        distinyInfoText.translatesAutoresizingMaskIntoConstraints = false
        distinyInfoText.centerXAnchor.constraint(equalTo: distinyInfoView.centerXAnchor).isActive = true
        distinyInfoText.centerYAnchor.constraint(equalTo: distinyInfoView.centerYAnchor).isActive = true
        distinyInfoText.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        distinyInfoText.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
        distinyInfoText.textAlignment = .center
    }
    
    func buildDriverCommentView(){
        let label = UILabel()
        self.modalView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -20).isActive = true
        label.topAnchor.constraint(equalTo: distinyInfoView.bottomAnchor, constant: 10).isActive = true
        label.numberOfLines = 3
        label.textAlignment = .center
    }
    
    func updateUI(){
        guard let driverName = self.user?.name,
            let image = user?.picture,
            let slug = schedule?.destiny.slug,
            let hour = schedule?.hour,
            let space = schedule?.space,
            let title = schedule?.destiny.title else { return  }
        
        DispatchQueue.main.async {
            self.driverNameText.text = driverName
            self.driverImageView.image = image
            self.distinyInfoText.text = "\(slug) - \(hour)"
            self.rideSpaceInfoText.text = space
            self.rideText.text = "\(slug) - \(title)"
        }
        
    }
    
    @objc func closeButtonAction(_ sender: Any){
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { finish in
            self.removeFromSuperview()
        }
    }
}
