//
//  ScheduleDriverInfoViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 15/07/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class ScheduleDriverInfoViewController: UIViewController {

    public init(schedule: Schedule) {
        self.schedule = schedule
        super.init(nibName: nil, bundle: nil)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let schedule: Schedule
    
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Rachel")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.8
        
        let colorTop = ThemeColor.shared.modalBackgroundColor.cgColor
        let colorBottom = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: UIScreen.main.bounds.height * 0.8)
        gradientLayer.opacity = 0.9
        
        imageView.layer.insertSublayer(gradientLayer, at: 0)
        return imageView
    }()
    
    private lazy var roundedBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.text = "Rachel Fernandes"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        return l
    }()
    
    private lazy var destinyLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = ThemeColor.shared.actionButtonColor
        l.text = "Terminal de integração de canasvieiras"
        l.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        l.textAlignment = .center
        l.alpha = 0.8
        return l
    }()
    
    private lazy var messageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "messageIcon"), for: .normal)
        button.backgroundColor = .none
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        return  button
    }()
    
    private lazy var reservationButton: UIButton = {
        let reservationButton = UIButton()
        reservationButton.setTitle("RESERVAR", for: .normal)
        reservationButton.setTitleColor(ThemeColor.shared.actionButtonColor, for: .normal)
        reservationButton.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        reservationButton.layer.borderColor = ThemeColor.shared.actionButtonColor.cgColor
        reservationButton.layer.borderWidth = 3
        reservationButton.layer.cornerRadius = 5
        reservationButton.clipsToBounds = true
        reservationButton.translatesAutoresizingMaskIntoConstraints = false
        return  reservationButton
    }()
    
    private lazy var closeButtonImageView: UIButton = {
        let closeButtonImageView = UIButton()
        closeButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        closeButtonImageView.setImage(UIImage(named: "Grey_close"), for: .normal)
        closeButtonImageView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return closeButtonImageView
    }()
    
    private func buildUI() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .black
        buildBackgroundImageView()
        buildRoundedBottomView()
        buildUserNameLabel()
        buildDestinyLabel()
        buildRideInfoView()
        buildActionButtons()
    }
    
    private lazy var rideInfoView: RideInfoView = {
        let rideInfoView = RideInfoView(schedule: schedule)
        rideInfoView.translatesAutoresizingMaskIntoConstraints = false
        return rideInfoView
    }()
    
    private func buildBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.8).isActive = true
    }
    
    private func buildRoundedBottomView() {
        view.addSubview(roundedBottomView)
        roundedBottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        roundedBottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        roundedBottomView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -50).isActive = true
        roundedBottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
    }
    
    private func buildUserNameLabel() {
        view.addSubview(userNameLabel)
        userNameLabel.bottomAnchor.constraint(equalTo: roundedBottomView.topAnchor, constant: -50).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: roundedBottomView.centerXAnchor).isActive = true
    }
    
    private func buildDestinyLabel() {
        view.addSubview(destinyLabel)
        destinyLabel.centerXAnchor.constraint(equalTo: userNameLabel.centerXAnchor).isActive = true
        destinyLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func buildRideInfoView() {
        roundedBottomView.addSubview(rideInfoView)
        rideInfoView.leftAnchor.constraint(equalTo: roundedBottomView.leftAnchor).isActive = true
        rideInfoView.rightAnchor.constraint(equalTo: roundedBottomView.rightAnchor).isActive = true
        rideInfoView.topAnchor.constraint(equalTo: roundedBottomView.topAnchor, constant: 10).isActive = true
        rideInfoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func buildActionButtons() {
        view.addSubview(messageButton)
        messageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        messageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(reservationButton)
        reservationButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 55).isActive = true
        reservationButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -55).isActive = true
        reservationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        reservationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(closeButtonImageView)
        closeButtonImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeButtonImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        closeButtonImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        closeButtonImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
    }
    
    @objc private func dismissView() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
