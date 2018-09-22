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
    var schedule = Schedule()
    
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
        buildWhitebackGround()
        buildRideInfo()
    }
    
    func buildWhitebackGround() {
        self.contentView.addSubview(whitebackView)
        whitebackView.backgroundColor = .white
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
        dayLabel.leftAnchor.constraint(equalTo: whitebackView.leftAnchor).isActive = true
        dayLabel.bottomAnchor.constraint(equalTo: whitebackView.topAnchor, constant: -3).isActive = true
        dayLabel.numberOfLines = 1
        dayLabel.textColor = #colorLiteral(red: 0.7215686275, green: 0.7215686275, blue: 0.7215686275, alpha: 1)
        dayLabel.text = "\("test"):"
        dayLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
}
