//
//  LoginViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 11/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FirebaseCore

class LoginViewController: UIViewController {
 
    var loginButton = UIButton()
    var modalView = UIView()
    var titleLabel = UILabel()
    var logoImageView = UIImageView()
    var messageLabel = UILabel()
    var userTextField = UITextField()
    var passwordTextField = UITextField()
    
    var shouldTransformerLayout = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = BackgroundViewWithAnimate(frame: self.view.frame)
        backgroundView.startBackgroundAnimate()
        self.view.addSubview(backgroundView)
        self.navigationController?.navigationBar.isHidden = true
        
        addBackModalView()
        addTitle()
//        addLogo()
        addMessage()
        prepareFramesForfacebookLoginButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareFramesForfacebookLoginButton(){
        self.view.addSubview(loginButton)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
    }
    func buildFBLoginButton(){
        let fbLoginButton = FBSDKLoginButton()
        self.view.addSubview(fbLoginButton)
        fbLoginButton.frame = loginButton.frame
        fbLoginButton.delegate = self
    }
    
    func addBackModalView() {
        self.view.addSubview(modalView)
        modalView.modalStyle()
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        modalView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 7).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -7).isActive = true
        modalView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        if UIScreen.main.bounds.height > 570 {
            modalView.heightAnchor.constraint(equalToConstant: 372).isActive = true
        }   else {
            modalView.heightAnchor.constraint(equalToConstant: 272).isActive = true
        }
    }
    
    func addTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.text = "Fim de aula"
        titleLabel.textColor = ThemeColor.shared.textColor
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
    }
    
    func addLogo(){
        let universityNameView = UniversityNameView()
        self.view.addSubview(universityNameView)
        universityNameView.translatesAutoresizingMaskIntoConstraints = false
        universityNameView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        universityNameView.topAnchor.constraint(equalTo: self.modalView.topAnchor, constant: 20).isActive = true
        universityNameView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        universityNameView.widthAnchor.constraint(equalToConstant: 230).isActive = true
    }
    
    func addMessage(){
        self.view.addSubview(messageLabel)
        messageLabel.text = "Para sua segurança é preciso que faça login."
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 2).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -2).isActive = true
        
        if UIScreen.main.bounds.height > 570 {
            messageLabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -60).isActive = true
        } else {
            messageLabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -30).isActive = true
        }
        
        messageLabel.textColor = ThemeColor.shared.textColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        buildFBLoginButton()
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        UserDefaults.standard.setValue(false, forKey: Identifier().userIsLogedIdentifier)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        Operation().retrieverUserFacebookInfo { user in
            DispatchQueue.main.async {
                let chooseGoalViewController = ChooseGoalViewController()
                chooseGoalViewController.user = user
                Operation().registerOnlyUser(user: user)
                self.navigationController?.pushViewController(chooseGoalViewController, animated: true)
            }
        }
    }
}
