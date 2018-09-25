//
//  ChooseGoalViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class ChooseGoalViewController: UIViewController{
    
    var modalView = UIView()
    var titleLabel = UILabel()
    var logoImageView = UIImageView()
    var user: User?
    var shouldGetuUserInfo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = BackgroundViewWithAnimate(frame: self.view.frame)
        backgroundView.startbackGroundAnimate()
        self.view.addSubview(backgroundView)
        self.navigationController?.navigationBar.isHidden = true
        
        addBackModalView()
        addTitle()
        addLogo()
        addPassagerAndDriverButton()
        
        // get user info when user not loged
        if shouldGetuUserInfo {
            Operation().retrieverUserFacebookInfo { (user) in
                self.user = user
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBackModalView() {
        self.view.addSubview(modalView)
        modalView.modalStyle()
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        modalView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 7).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -7).isActive = true
        modalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        modalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
    }
    
    func addTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.text = "Fim de aula"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
    }
    
    func addLogo(){
        self.view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: self.modalView.topAnchor, constant: 20).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 175).isActive = true
        logoImageView.image = #imageLiteral(resourceName: "logo")
    }
    
    func addPassagerAndDriverButton() {
        let driverButton = UIButton()
        self.view.addSubview(driverButton)
        driverButton.translatesAutoresizingMaskIntoConstraints = false
        driverButton.rightAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        driverButton.leftAnchor.constraint(equalTo: self.modalView.leftAnchor).isActive = true
        driverButton.topAnchor.constraint(equalTo: self.modalView.centerYAnchor).isActive = true
        driverButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        driverButton.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        driverButton.clipsToBounds = true
        driverButton.layer.cornerRadius = 10
        driverButton.setTitle("Dar Carona", for: .normal)
        driverButton.setTitleColor(.white, for: .normal)
        driverButton.setTitleColor(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), for: .highlighted)
        driverButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        driverButton.addTarget(self, action: #selector(driverButtonAction(_:)), for: .touchUpInside)
        
        let passagerButton = UIButton()
        self.view.addSubview(passagerButton)
        passagerButton.translatesAutoresizingMaskIntoConstraints = false
        passagerButton.rightAnchor.constraint(equalTo: self.modalView.rightAnchor).isActive = true
        passagerButton.leftAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passagerButton.topAnchor.constraint(equalTo: driverButton.bottomAnchor, constant: 20).isActive = true
        passagerButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        passagerButton.backgroundColor = .white
        passagerButton.clipsToBounds = true
        passagerButton.layer.cornerRadius = 10
        passagerButton.setTitle("Pegar Carona", for: .normal)
        passagerButton.setTitleColor(#colorLiteral(red: 0.8784313725, green: 0.1019607843, blue: 0.1019607843, alpha: 1), for: .normal)
        passagerButton.setTitleColor(#colorLiteral(red: 0.3058823529, green: 0.3058823529, blue: 0.3058823529, alpha: 1), for: .highlighted)
        passagerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        passagerButton.addTarget(self, action: #selector(passagerButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func driverButtonAction(_ sender: Any) {
        let chooseDestinyViewController = ChooseDestinyViewController()
        chooseDestinyViewController.decisionType = .driver
        chooseDestinyViewController.user = self.user
        
        let nav = UINavigationController(rootViewController: chooseDestinyViewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func passagerButtonAction(_ sender: Any) {
        let chooseDestinyViewController = ChooseDestinyViewController()
        chooseDestinyViewController.user = self.user
        chooseDestinyViewController.decisionType = .passenger
        let nav = UINavigationController(rootViewController: chooseDestinyViewController)
        self.present(nav, animated: true, completion: nil)
    }
}

