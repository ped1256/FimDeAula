//
//  UserInfoFormViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 10/04/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

class UserInfoFormViewController: UIViewController {

    let modalView = UIView()
    enum TextFieldType: Int {
        case name = 1
        case ddd = 2
        case phoneNumber = 3
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Cadastre-se"
        l.textColor = .white
        l.alpha = 0.0
        l.font = UIFont.systemFont(ofSize: 25)
        return l
    }()
    
    private lazy var nameTextfield: YoshikoTextField = {
        let l = YoshikoTextField()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.actionButtonColor
        l.borderSize = 1
        l.placeholder = "Nome"
        l.placeholderColor = ThemeColor.shared.secondaryTextColor
        l.textColor = .white
        return l
    }()
    
    private lazy var areaCodeTextField: YoshikoTextField = {
        let l = YoshikoTextField()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.actionButtonColor
        l.placeholderColor = ThemeColor.shared.secondaryTextColor
        l.borderSize = 1
        l.delegate = self
        l.placeholder = "DDD"
        l.keyboardType = .numberPad
        l.tag = 2
        l.textColor = .white
        return l
    }()
    
    private lazy var phoneNumberTextField: YoshikoTextField = {
        let l = YoshikoTextField()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.actionButtonColor
        l.placeholderColor = ThemeColor.shared.secondaryTextColor
        l.borderSize = 1
        l.delegate = self
        l.placeholder = "Numero"
        l.tag = 3
        l.keyboardType = .numberPad
        l.textColor = .white
        return l
    }()
    
    private lazy var emailTextField: YoshikoTextField = {
        let l = YoshikoTextField()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.actionButtonColor
        l.placeholderColor = ThemeColor.shared.secondaryTextColor
        l.borderSize = 1
        l.delegate = self
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
        buildNameTextField()
        buildAreaCodeTextField()
        buildPhoneNumberTextField()
        buildEmailTextField()
        
        buttonController.install(in: self)
    }
    
    private lazy var buttonController: PUKeyboardFollowingButtonController = {
        let buttonController = PUKeyboardFollowingButtonController(actionTitle: "Confirmar")
        buttonController.actionButton.isEnabled = false
        
        buttonController.buttonTapHandler = { [weak self] in
            self?.performRegister()
        }
        
       return buttonController
    }()
    
    private func hideKeyboard() {
        nameTextfield.resignFirstResponder()
        areaCodeTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    private func performRegister() {
        hideKeyboard()
        
        guard let name = nameTextfield.text, let email = emailTextField.text, let areaCode = areaCodeTextField.text, let number = phoneNumberTextField.text else { return }
        let phoneNumber = "\(areaCode)\(number)"
        let user = User(name: name , id: "test" , email: email, phoneNumber: phoneNumber)

        Operation().registerOnlyUser(user: user)
        
        let loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        loadingView.animating.startAnimating()
        
        Operation().getUserInfo(id: user.id) { user in
            DispatchQueue.main.async {
                loadingView.animating.stopAnimating()
                loadingView.removeFromSuperview()

                guard let user = user else { return }
                let choseGoalViewController = ChooseGoalViewController(user: user)
                self.present(choseGoalViewController, animated: true, completion: nil)
            }
        }
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
        modalView.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2705882353, blue: 0.3176470588, alpha: 1)
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true

    }
    
    private func buildTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
    }
    
    private func buildNameTextField() {
        self.modalView.addSubview(nameTextfield)
        nameTextfield.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 10).isActive = true
        nameTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextfield.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 10).isActive = true
        nameTextfield.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -10).isActive = true
        nameTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func buildAreaCodeTextField() {
        self.modalView.addSubview(areaCodeTextField)
        areaCodeTextField.topAnchor.constraint(equalTo: nameTextfield.topAnchor, constant: 56).isActive = true
        areaCodeTextField.leftAnchor.constraint(equalTo: nameTextfield.leftAnchor).isActive = true
        areaCodeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        areaCodeTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        areaCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private func buildPhoneNumberTextField(){
        self.modalView.addSubview(phoneNumberTextField)
        phoneNumberTextField.topAnchor.constraint(equalTo: areaCodeTextField.topAnchor).isActive = true
        phoneNumberTextField.leftAnchor.constraint(equalTo: areaCodeTextField.rightAnchor, constant: 10).isActive = true
        phoneNumberTextField.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -10).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func buildEmailTextField() {
        self.modalView.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: areaCodeTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 10).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        guard let name = nameTextfield.text, let email = emailTextField.text, let areaCode = areaCodeTextField.text, let number = phoneNumberTextField.text else { return true }
        
        return name.isEmpty || areaCode.isEmpty || number.isEmpty || email.isEmpty
    }
}

extension UserInfoFormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let char = string.cString(using: String.Encoding.utf8) else { return true }
        let isBackSpace = strcmp(char, "\\b")
        guard isBackSpace != -92 else { return true }
        guard let type = TextFieldType(rawValue: textField.tag) else { return true }
        guard let count = textField.text?.count else { return true }
        
        switch type {
        case .ddd:
            if count >= 2 {
                nextTextField(from: textField)
                return false
            } else {
              return true
            }
            
        case .phoneNumber:
            if count >= 9 {
                nextTextField(from: textField)
                return false
            } else {
                return true
            }
            
        default:
            return true
        }
    }
    
    func nextTextField(from textField: UITextField){
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}
