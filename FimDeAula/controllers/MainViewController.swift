//
//  ViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 10/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var acceptButton = UIButton()
    var modalView = UIView()
    var titleLabel = UILabel()
    var logoImageView = UIImageView()
    var messageLabel = UILabel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let backgroundView = BackgroundViewWithAnimate(frame: self.view.frame)
        backgroundView.startbackGroundAnimate()
        self.view.addSubview(backgroundView)
        self.navigationController?.navigationBar.isHidden = true
        addButtonaccept()
        addBackModalView()
        addTitle()
        addLogo()
        addMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addButtonaccept(){
        self.view.addSubview(acceptButton)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        
        acceptButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        acceptButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        acceptButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        if App().isIphoneX() {
            acceptButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        } else {
            acceptButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        }
        
        acceptButton.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
        
        acceptButton.setTitle("Continuar", for: .normal)
        acceptButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        acceptButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        acceptButton.addTarget(self, action: #selector(acceptAction(_:)), for: .touchUpInside)
    }
    
    func addBackModalView() {
        self.view.addSubview(modalView)
        modalView.modalStyle()
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 7).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -7).isActive = true
        modalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        modalView.heightAnchor.constraint(equalToConstant: 372).isActive = true
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
    
    func addMessage(){
        self.view.addSubview(messageLabel)
        messageLabel.text = "Viaje rapido, em segurança, e faça amizades"
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 2).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -2).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -40).isActive = true
        
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    @objc func acceptAction(_ sender: Any){
        UserDefaults.standard.set(false, forKey: Identifier().userFirstTimeIdentifier)
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }

}
