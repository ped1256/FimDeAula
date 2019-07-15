//
//  LoginFormViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 10/04/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

class LoginFormViewController: UIViewController {
    
    let modalView = UIView()

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Entrar"
        l.textColor = .white
        l.alpha = 0.0
        l.font = UIFont.systemFont(ofSize: 25)
        return l
    }()
    
    private lazy var passwordTextField: YoshikoTextField = {
        let l = YoshikoTextField()
        l.isSecureTextEntry = true
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.actionButtonColor
        l.borderSize = 1
        l.placeholder = "Senha"
        l.placeholderColor = ThemeColor.shared.secondaryTextColor
        l.textColor = .white
        return l
    }()
    
    private lazy var closeButtonImageView: UIButton = {
        let closeButtonImageView = UIButton()
        closeButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        closeButtonImageView.setImage(UIImage(named: "Grey_close"), for: .normal)
        closeButtonImageView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return closeButtonImageView
    }()
    
    private lazy var emailTextField: YoshikoTextField = {
        let l = YoshikoTextField()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.actionButtonColor
        l.placeholderColor = ThemeColor.shared.secondaryTextColor
        l.borderSize = 1
        l.placeholder = "e-mail"
        l.tag = 4
        l.keyboardType = .emailAddress
        l.textColor = .white
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeColor.shared.modalBackgroundColor
        
        buildModalView()
        buildTitle()
        buildCloseButton()
        buildEmailTextField()
        buildPasswordTextField()
        buttonController.install(in: self)
    }
    
    private lazy var buttonController: PUKeyboardFollowingButtonController = {
        let buttonController = PUKeyboardFollowingButtonController(actionTitle: "Confirmar")
        buttonController.actionButton.isEnabled = false
        
        buttonController.buttonTapHandler = { [weak self] in
            self?.perform()
        }
        
        return buttonController
    }()
    
    private func hideKeyboard() {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    private func perform() {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        showWithAnimation()
    }
    
    private func buildModalView() {
        self.view.addSubview(modalView)
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        modalView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        modalView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        modalView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        modalView.backgroundColor = #colorLiteral(red: 0.2253112676, green: 0.2723168075, blue: 0.3192648458, alpha: 1)
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true
        
    }
    
    private func buildTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
    }
    
    private func buildCloseButton() {
        self.view.addSubview(closeButtonImageView)
        NSLayoutConstraint.activate([
            closeButtonImageView.heightAnchor.constraint(equalToConstant: 22),
            closeButtonImageView.widthAnchor.constraint(equalToConstant: 22),
            closeButtonImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0),
            closeButtonImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -22)
            ])
    }
    
    private func buildEmailTextField() {
        self.modalView.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 15).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 10).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: modalView.widthAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func buildPasswordTextField() {
        self.modalView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showWithAnimation() {
        UIView.animate(withDuration: 0.6) {
            self.titleLabel.alpha = 1.0
            self.modalView.alpha = 1.0
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if !isFieldsEmpty {
            buttonController.actionButton.isEnabled = true
            return
        } else if buttonController.actionButton.isEnabled {
            buttonController.actionButton.isEnabled = false
        }
    }
    
    private var isFieldsEmpty: Bool {
        guard let name = passwordTextField.text, let email = emailTextField.text else { return true }
        
        return name.isEmpty || email.isEmpty
    }
}

