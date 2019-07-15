//
//  HomeRideCell.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 22/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class HomeRideCell: UITableViewCell {
    static var identifier = "homeRideCellIdentifier"

    var ride = Schedule(){
        didSet {
            updtadeUI()
        }
    }
    
    private lazy var userImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "Rachel")
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 70).isActive = true
        i.widthAnchor.constraint(equalToConstant: 70).isActive = true
        i.clipsToBounds = true
        i.layer.cornerRadius = 35
        return i
    }()
    
    private lazy var userNameLabel: UILabel = {
        let i = UILabel()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.textColor = ThemeColor.shared.cellTitleColor
        i.text = "Rachel Fernandes"
        return i
    }()
    
    private lazy var destinyContentView: ContentView = {
        let destinyContentView = ContentView()
        destinyContentView.translatesAutoresizingMaskIntoConstraints = false
        return destinyContentView
    }()
    
    private lazy var hourContentView: ContentView = {
        let destinyContentView = ContentView()
        destinyContentView.translatesAutoresizingMaskIntoConstraints = false
        return destinyContentView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .none
        self.selectionStyle = .none
        
        buildUserImageView()
        buildUsernameLabel()
        buildDestinyContent()
        buildHourContent()
    }
    
    private func updtadeUI() {
        hourContentView.title = ride.hour
        destinyContentView.title = ride.destiny.slug
    }
    
    private func buildUserImageView() {
        addSubview(userImageView)
        userImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
    }
    
    private func buildUsernameLabel() {
        addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor, constant: 7).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 7).isActive = true
    }
    
    private func buildDestinyContent() {
        self.addSubview(destinyContentView)
        destinyContentView.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor).isActive = true
        destinyContentView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        destinyContentView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 7).isActive = true
        destinyContentView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func buildHourContent() {
        addSubview(hourContentView)
        hourContentView.leftAnchor.constraint(equalTo: destinyContentView.rightAnchor, constant: 7).isActive = true
        hourContentView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        hourContentView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 7).isActive = true
        hourContentView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }

    
}
