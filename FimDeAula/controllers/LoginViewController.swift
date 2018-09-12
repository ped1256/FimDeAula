//
//  LoginViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 11/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
 
    var loginButton = UIButton()
    var modalView = UIView()
    var titleLabel = UILabel()
    var logoImageView = UIImageView()
    var messageLabel = UILabel()
    var userTextField = UITextField()
    var passwordTextField = UITextField()
    var backgroundView = UIView()
    
    var shouldTransformerLayout = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView = BackgroundViewWithAnimate(frame: self.view.frame)
        
        self.view.addSubview(backgroundView)
        self.navigationController?.navigationBar.isHidden = true
        
        addBackModalView()
        addTitle()
        addLogo()
        addMessage()
        addForm()
        addButtonaccept()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtonaccept(){
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.widthAnchor.constraint(equalToConstant: 220).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        if UIScreen.main.bounds.height > 570 {
            loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 20).isActive = true
        } else {
            loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10).isActive = true
        }
        
        loginButton.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
        loginButton.layer.cornerRadius = 18
        loginButton.clipsToBounds = true
        loginButton.setTitle("Entrar", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        loginButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginActionButton(_:)), for: .touchUpInside)
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
        titleLabel.text = "Fim de aula App"
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
        messageLabel.text = "Para sua segurança é preciso que faça login com a matricula da faculdade."
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 2).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -2).isActive = true
        
        if UIScreen.main.bounds.height > 570 {
            messageLabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -60).isActive = true
        } else {
            messageLabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -30).isActive = true
        }
        
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    func addForm() {
        self.view.addSubview(userTextField)
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 7).isActive = true
        userTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -7).isActive = true
        userTextField.heightAnchor.constraint(equalToConstant: 43).isActive = true
        userTextField.topAnchor.constraint(equalTo: self.modalView.bottomAnchor, constant: 20).isActive = true
        userTextField.delegate = self
        userTextField.backgroundColor = .white
        userTextField.placeholder = "Matricula ou usuário"
        
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 7).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -7).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 43).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: self.userTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.backgroundColor = .white
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Senha"
    }
    
    @objc func loginActionButton(_ sender: Any){
        dismissKeyboardAndAdjusteLayout()
        let loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        loadingView.start {
            loadingView.removeFromSuperview()
            let chooseGoalViewController = ChooseGoalViewController()
            self.navigationController?.pushViewController(chooseGoalViewController, animated: true)
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if shouldTransformerLayout {
            shouldTransformerLayout = false
            UIView.animate(withDuration: 0.5) {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - 250, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboardAndAdjusteLayout()
        return true
    }
    
    @objc func dismissKeyboardAndAdjusteLayout(){
        passwordTextField.resignFirstResponder()
        userTextField.resignFirstResponder()
        
        if !shouldTransformerLayout {
            UIView.animate(withDuration: 0.5) {
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 250, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
            shouldTransformerLayout = true
        }
    }
}
