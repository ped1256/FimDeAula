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
    
    let schedule: Schedule
    
    public init(schedule: Schedule) {
        self.schedule = schedule
        super.init(frame: .zero)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var hourContent: RideInfoContent = {
        let hourContent = RideInfoContent()
        hourContent.title = "Horário"
        hourContent.subtitle = self.schedule.hour
        hourContent.translatesAutoresizingMaskIntoConstraints = false
        return hourContent
    }()
    
    private lazy var destinyContent: RideInfoContent = {
        let destinyContent = RideInfoContent()
        destinyContent.title = "Destino"
        destinyContent.subtitle = self.schedule.destiny.slug
        destinyContent.translatesAutoresizingMaskIntoConstraints = false
        return destinyContent
    }()
    
    private lazy var spacesContent: RideInfoContent = {
        let spacesContent = RideInfoContent()
        spacesContent.title = "Vagas"
        spacesContent.subtitle = self.schedule.space
        spacesContent.horizontalLineRight.isHidden = true
        spacesContent.translatesAutoresizingMaskIntoConstraints = false
        return spacesContent
    }()
    
    private func buildUI() {
        self.addSubview(hourContent)
        self.addSubview(destinyContent)
        self.addSubview(spacesContent)
        
        hourContent.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        hourContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        hourContent.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hourContent.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        destinyContent.rightAnchor.constraint(equalTo: hourContent.leftAnchor, constant: -10).isActive = true
        destinyContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        destinyContent.widthAnchor.constraint(equalToConstant: 100).isActive = true
        destinyContent.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        spacesContent.leftAnchor.constraint(equalTo: hourContent.rightAnchor, constant: 10).isActive = true
        spacesContent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        spacesContent.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spacesContent.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
//    @objc func callAction(_ sender: Any){
//        guard let user = user else { return }
//        if let url = URL(string: "telprompt:\(user.phoneNumber)") {
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:])
//            }
//        }
//    }
//
//    @objc func openWhatsaap(_ sender: Any) {
//        guard let user = user else { return }
//        if let url = URL(string:"https://api.whatsapp.com/send?phone=+55\(user.phoneNumber)") {
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:])
//            }
//        }
//    }
//
}

private class RideInfoContent: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String? {
        didSet{
            updateUI()
        }
    }

    var subtitle: String? {
        didSet{
            updateUI()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15, weight: .light)
        l.textColor = ThemeColor.shared.actionButtonSecondaryColor
        return l
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        l.textColor = .black
        return l
    }()
    
    public lazy var horizontalLineRight: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.layer.cornerRadius = 1
        v.backgroundColor = ThemeColor.shared.modalBackgroundColor
        return v
    }()
    
    private func buildUI() {
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(horizontalLineRight)
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
        subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        
        horizontalLineRight.topAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        horizontalLineRight.bottomAnchor.constraint(equalTo: subtitleLabel.centerYAnchor).isActive = true
        horizontalLineRight.leftAnchor.constraint(equalTo: subtitleLabel.rightAnchor, constant: 25).isActive = true
        horizontalLineRight.widthAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func updateUI() {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
