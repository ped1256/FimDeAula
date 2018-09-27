//
//  AccounRideCell.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 26/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

protocol AccounRideCellDelegate {
    func didTouchInRemoveButton(schedule: Schedule)
}

class AccountRideCell: UITableViewCell {
    
    static var identifier = "accountRideCellIdentifier"
    let backView = UIView()
    let rideDescriptionText = UILabel()
    let rideTitleText = UILabel()
    let deleteButton = UIButton()
    var schedule = Schedule()
    var delegate: AccounRideCellDelegate?
    
    func buildUI() {
        self.contentView.backgroundColor = .white
        self.selectionStyle = .none
        buildBackView()
        buildRideTitle()
        buildRideDescriptionText()
        buildRemoveButtom()
        
    }
    
    func buildBackView() {
        self.contentView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        backView.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
        backView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        backView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
    }
    
    func buildRideTitle(){
        contentView.addSubview(rideTitleText)
        rideTitleText.translatesAutoresizingMaskIntoConstraints = false
        
        rideTitleText.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20).isActive = true
        rideTitleText.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -40).isActive = true
        rideTitleText.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20).isActive = true
        
        if App().isIphoneSE() {
            rideTitleText.font = UIFont.systemFont(ofSize: 20)
        } else {
            rideTitleText.font = UIFont.systemFont(ofSize: 22)
        }
        
        rideTitleText.numberOfLines = 3
        rideTitleText.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        rideTitleText.text = "\(schedule.day) - \(schedule.hour)"
    }
    
    func buildRideDescriptionText(){
        contentView.addSubview(rideDescriptionText)
        rideDescriptionText.translatesAutoresizingMaskIntoConstraints = false
        
        rideDescriptionText.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20).isActive = true
        rideDescriptionText.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -40).isActive = true
        rideDescriptionText.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
        
        if App().isIphoneSE() {
            rideDescriptionText.font = UIFont.systemFont(ofSize: 18)
        } else {
            rideDescriptionText.font = UIFont.systemFont(ofSize: 20)
        }
        
        rideDescriptionText.numberOfLines = 3
        rideDescriptionText.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        rideDescriptionText.text = schedule.destiny.title
    }
    
    func buildRemoveButtom(){
        self.contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
        deleteButton.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -10).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 3
        deleteButton.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
    }

    @objc func deleteAction(_ sender: Any) {
        delegate?.didTouchInRemoveButton(schedule: schedule)
    }
}
