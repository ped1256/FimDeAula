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
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Cadastro"
        l.textColor = .white
        l.alpha = 0.0
        l.font = UIFont.systemFont(ofSize: 25)
        return l
    }()
    
    private lazy var actionButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .black
        b.alpha = 0
        return b
    }()
    
    private lazy var nameTextfield: YoshikoTextField = {
        let l = YoshikoTextField()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.actionButtonColor
        l.borderSize = 1
        l.placeholder = "Nome"
        l.textColor = ThemeColor.shared.modalBackgroundColor
        return l
    }()
    
    private lazy var areaCodeTextField: YoshikoTextField = {
        let l = YoshikoTextField()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.activeBorderColor = ThemeColor.shared.modalBackgroundColor
        l.borderSize = 1
        l.placeholder = "DDD"
        l.textColor = ThemeColor.shared.modalBackgroundColor
        l.textAlignment = .center
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeColor.shared.modalBackgroundColor
        
        buildModalView()
        buildTitle()
        buildNameTextField()
//        buildActionButton()
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
        modalView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true
        modalView.alpha = 0

    }
    
    private func buildTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
    }
    
    private func buildNameTextField() {
        self.modalView.addSubview(nameTextfield)
        nameTextfield.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 10).isActive = true
        nameTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextfield.leftAnchor.constraint(equalTo: modalView.leftAnchor, constant: 10).isActive = true
        nameTextfield.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -10).isActive = true
    }
    
    private func buildAreaCodeTextField() {
        self.modalView.addSubview(areaCodeTextField)
        areaCodeTextField.topAnchor.constraint(equalTo: nameTextfield.topAnchor, constant: 5).isActive = true
        areaCodeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        areaCodeTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
//    private func buildActionButton() {
//        self.modalView.addSubview(actionButton)
//        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        actionButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        actionButton.rightAnchor.constraint(equalTo: modalView.rightAnchor, constant: -20).isActive = true
//    }
    
    
    private func showWithAnimation() {
        UIView.animate(withDuration: 0.6) {
            self.actionButton.alpha = 1.0
            self.titleLabel.alpha = 1.0
            self.modalView.alpha = 1.0
        }
    }
}
