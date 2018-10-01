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
    
    var dayLabel = UILabel()
    var hourLabel = UILabel()
    var whitebackView = UIView()
    var nameTitle = UILabel()
    var driverName = UILabel()
    var destinyTitle = UILabel()
    var destinyDescription = UILabel()
    var ride = Schedule(){
        didSet{
            updateUI()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() {
        self.contentView.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.2078431373, blue: 0.2078431373, alpha: 1)
        self.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.3058823529, blue: 0.3058823529, alpha: 1)
        self.selectionStyle = .none
        buildWhitebackGround()
        buildRideInfo()
        buildDriverInfo()
        buildDestinyInfo()
    }
    
    func buildWhitebackGround() {
        self.contentView.addSubview(whitebackView)
        whitebackView.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
        whitebackView.clipsToBounds = true
        whitebackView.layer.cornerRadius = 5
        
        whitebackView.translatesAutoresizingMaskIntoConstraints = false
        whitebackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        whitebackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true
        whitebackView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        whitebackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    func buildRideInfo(){
        self.contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.leftAnchor.constraint(equalTo: whitebackView.leftAnchor, constant: 5).isActive = true
        dayLabel.bottomAnchor.constraint(equalTo: whitebackView.topAnchor, constant: -5).isActive = true
        dayLabel.numberOfLines = 1
        dayLabel.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        dayLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        self.contentView.addSubview(hourLabel)
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.leftAnchor.constraint(equalTo: dayLabel.rightAnchor, constant: 8).isActive = true
        hourLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor).isActive = true
        hourLabel.numberOfLines = 1
        hourLabel.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        hourLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
    }
    func buildDriverInfo(){
        self.whitebackView.addSubview(nameTitle)
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.leftAnchor.constraint(equalTo: whitebackView.leftAnchor, constant: 5).isActive = true
        nameTitle.topAnchor.constraint(equalTo: whitebackView.topAnchor, constant: 12).isActive = true
        nameTitle.numberOfLines = 1
        nameTitle.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1).withAlphaComponent(0.6)
        nameTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        self.whitebackView.addSubview(driverName)
        driverName.translatesAutoresizingMaskIntoConstraints = false
        driverName.leftAnchor.constraint(equalTo: nameTitle.rightAnchor, constant: 8).isActive = true
        driverName.centerYAnchor.constraint(equalTo: nameTitle.centerYAnchor).isActive = true
        driverName.numberOfLines = 1
        driverName.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1).withAlphaComponent(0.6)
        driverName.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    func buildDestinyInfo(){
        self.whitebackView.addSubview(destinyTitle)
        destinyTitle.translatesAutoresizingMaskIntoConstraints = false
        destinyTitle.leftAnchor.constraint(equalTo: whitebackView.leftAnchor, constant: 5).isActive = true
        destinyTitle.topAnchor.constraint(equalTo: nameTitle.bottomAnchor , constant: 12).isActive = true
        destinyTitle.numberOfLines = 1
        destinyTitle.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1).withAlphaComponent(0.6)
        destinyTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        self.whitebackView.addSubview(destinyDescription)
        destinyDescription.translatesAutoresizingMaskIntoConstraints = false
        destinyDescription.leftAnchor.constraint(equalTo: destinyTitle.rightAnchor, constant: 15).isActive = true
        destinyDescription.rightAnchor.constraint(equalTo: whitebackView.rightAnchor, constant: -8).isActive = true
        destinyDescription.topAnchor.constraint(equalTo: destinyTitle.topAnchor, constant: 3).isActive = true
        destinyDescription.numberOfLines = 3
        destinyDescription.textAlignment = .center
        destinyDescription.textColor = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1).withAlphaComponent(0.6)
        destinyDescription.text = "\(PreDestinys.TICAN.rawValue)"
        destinyDescription.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    func updateUI() {
        dayLabel.text = ride.day
        driverName.text = ride.user?.name
        hourLabel.text = ride.hour
        destinyDescription.text = "\(ride.destiny.slug) - \(ride.destiny.title)"
    }
}
