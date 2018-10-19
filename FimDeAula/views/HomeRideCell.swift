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
    
    var mapView = UIImageView()
    var slugDestinyView = UIView()
    var slugDestinyLabel = UILabel()
    var rideInfoView = UIView()
    var hourLabel = UILabel()
    var dayLabel = UILabel()
    var driverImageView = UIImageView()

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
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
        buildInfoView()
        buildMapView()
        buildDestinySlugView()
        buildRideInfo()
        
    }
    
    func buildInfoView(){
        self.contentView.addSubview(rideInfoView)
        rideInfoView.translatesAutoresizingMaskIntoConstraints = false
        rideInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        rideInfoView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        rideInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        rideInfoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        rideInfoView.backgroundColor = .white
        rideInfoView.layer.cornerRadius = 10
        rideInfoView.clipsToBounds = true
        rideInfoView.isHidden = true

    }
    
    func buildMapView(){
        self.contentView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        mapView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
        mapView.isHidden = true
        
        self.contentView.addSubview(driverImageView)
        driverImageView.translatesAutoresizingMaskIntoConstraints = false
        driverImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        driverImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        driverImageView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 10).isActive = true
        driverImageView.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 10).isActive = true
        driverImageView.layer.cornerRadius = 40
        driverImageView.clipsToBounds = true
        driverImageView.isHidden = true
    }

    func buildDestinySlugView() {
        mapView.addSubview(slugDestinyView)
        slugDestinyView.translatesAutoresizingMaskIntoConstraints = false
        slugDestinyView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        slugDestinyView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        slugDestinyView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 20).isActive = true
        slugDestinyView.rightAnchor.constraint(equalTo: mapView.rightAnchor, constant: -20).isActive = true
        slugDestinyView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        slugDestinyView.layer.cornerRadius = 10
        slugDestinyView.clipsToBounds = true
        slugDestinyView.isHidden = true

        slugDestinyView.addSubview(slugDestinyLabel)
        slugDestinyLabel.translatesAutoresizingMaskIntoConstraints = false
        slugDestinyLabel.centerXAnchor.constraint(equalTo: slugDestinyView.centerXAnchor).isActive = true
        slugDestinyLabel.centerYAnchor.constraint(equalTo: slugDestinyView.centerYAnchor).isActive = true
        slugDestinyLabel.font = UIFont.systemFont(ofSize: 30)
        slugDestinyLabel.textColor = ThemeColor.shared.textColor
        slugDestinyLabel.isHidden = true
        
    }
    
    func buildRideInfo(){
        self.rideInfoView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 20).isActive = true
        dayLabel.bottomAnchor.constraint(equalTo: rideInfoView.bottomAnchor, constant: -5).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: 200)
        dayLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dayLabel.numberOfLines = 1
        dayLabel.textColor = ThemeColor.shared.cellBackgroundColor
        dayLabel.font = UIFont.systemFont(ofSize: 18)
        dayLabel.isHidden = true
    }

    func updateUI() {
        slugDestinyLabel.text = ride.destiny.slug
        dayLabel.text = "\(ride.day) : \(ride.hour)"
        guard let userId = ride.user?.id else { return }
   
        ride.user?.picturePath = "http://graph.facebook.com/\(userId)/picture?type=large"
        ride.user?.parseImage {
            DispatchQueue.main.async {
                self.driverImageView.image = self.ride.user?.picture
            }
        }

        Util.makeMapSnapshot(location: ride.destiny.location, completion: { (image) in
            self.mapView.image = image
            self.mapView.isHidden = false
            self.rideInfoView.isHidden = false
            self.dayLabel.isHidden = false
            self.slugDestinyLabel.isHidden = false
            self.slugDestinyView.isHidden = false
            self.driverImageView.isHidden = false
        })
    }
}
