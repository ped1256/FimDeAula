//
//  ChooseGoalViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class ChooseGoalViewController: UIViewController {
    
    var modalView = UIView()
    var titleLabel = UILabel()
    var logoImageView = UIImageView()
    var user: User?
    let driverButton = FAActionButtom()
    var shouldGetuUserInfo: Bool = false
    let accountIcon = UIButton()
    
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
        addPassagerAndDriverButton()
        addAccountButton()
        
        if shouldGetuUserInfo {
            Operation().retrieverUserFacebookInfo { (user) in
                self.user = user
                DispatchQueue.main.async {
                    self.accountIcon.isHidden = false
                    self.driverButton.status = .loaded
                }
            }
        } else {
            self.driverButton.status = .loaded
            accountIcon.isHidden = false
            driverButton.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAccountButton(){
        self.view.addSubview(accountIcon)
        accountIcon.isHidden = true
        accountIcon.translatesAutoresizingMaskIntoConstraints = false
        accountIcon.heightAnchor.constraint(equalToConstant: 47).isActive = true
        accountIcon.widthAnchor.constraint(equalToConstant: 47).isActive = true
        accountIcon.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        accountIcon.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        accountIcon.setImage(#imageLiteral(resourceName: "accountIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        accountIcon.addTarget(self, action: #selector(accountAction(_:)), for: .touchUpInside)
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
        titleLabel.textColor = ThemeColor.shared.textColor
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
        self.view.addSubview(driverButton)
        driverButton.translatesAutoresizingMaskIntoConstraints = false
        driverButton.rightAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        driverButton.leftAnchor.constraint(equalTo: self.modalView.leftAnchor).isActive = true
        driverButton.topAnchor.constraint(equalTo: self.modalView.centerYAnchor).isActive = true
        driverButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        driverButton.backgroundColor = ThemeColor.shared.actionButtonColor
        driverButton.clipsToBounds = true
        driverButton.layer.cornerRadius = 10
        driverButton.setTitle("Dar Carona", for: .normal)
        driverButton.setTitleColor(ThemeColor.shared.textColor, for: .normal)
        driverButton.setTitleColor(ThemeColor.shared.actionButtonSecondaryColor, for: .highlighted)
        driverButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        driverButton.addTarget(self, action: #selector(driverButtonAction(_:)), for: .touchUpInside)
        driverButton.status = .loading
        
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
        passagerButton.setTitleColor(ThemeColor.shared.actionButtonColor, for: .normal)
        passagerButton.setTitleColor(ThemeColor.shared.cellBackgroundColor, for: .highlighted)
        passagerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        passagerButton.addTarget(self, action: #selector(passagerButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func driverButtonAction(_ sender: Any) {
        guard let id = self.user?.id else { return }
        let load = LoadingView(frame: self.view.frame)
        self.view.addSubview(load)
        load.animating.startAnimating()
        
        Operation().getUserInfo(id: id) { user in
            guard let user = user else { return }
            
            DispatchQueue.main.async {
                load.animating.stopAnimating()
                load.removeFromSuperview()
            }
            
            if user.phoneNumber.isEmpty {
                DispatchQueue.main.async {
                    let formNumber = UserPhoneNumberForm(frame: self.view.frame)
                    formNumber.delegate = self
                    formNumber.buildUI()
                    self.view.addSubview(formNumber)
                }
            } else {
                DispatchQueue.main.async {
                    let chooseDestinyViewController = ChooseDestinyViewController()
                    chooseDestinyViewController.decisionType = .driver
                    chooseDestinyViewController.user = self.user
                    
                    let nav = AppNavigationController(rootViewController: chooseDestinyViewController)
                    self.present(nav, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func passagerButtonAction(_ sender: Any) {
        let chooseDestinyViewController = ChooseDestinyViewController()
        chooseDestinyViewController.user = self.user
        chooseDestinyViewController.decisionType = .passenger
        let nav = AppNavigationController(rootViewController: chooseDestinyViewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func accountAction(_ sender: Any){
        let userAccountViewController = AccountViewController()
        userAccountViewController.user = user
        self.present(userAccountViewController, animated: true, completion: nil)
    }
}

extension ChooseGoalViewController: UserPhoneNumberFormDelegate {
    
    func didTouchAcceptButton(value: String) {
        guard let user = self.user else { return }
        Operation().addUserPhoneNumber(user: user , value: value)
        
        let chooseDestinyViewController = ChooseDestinyViewController()
        chooseDestinyViewController.decisionType = .driver
        chooseDestinyViewController.user = self.user
        chooseDestinyViewController.user?.phoneNumber = value
        
        let nav = AppNavigationController(rootViewController: chooseDestinyViewController)
        self.present(nav, animated: true, completion: nil)
    }
}

//extension ChooseGoalViewController: UIWebViewDelegate {
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print("URL :", webView.request?.url?.absoluteString)
//
//        return true
//    }
//}

//webView.frame = self.view.frame
//
//
//self.view.addSubview(webView)
//
//guard let url = URL(string: "http://graduacao.cesusc.edu.br/projetos/nucleo/uteis/login.php?&tid=0&lid=0&pid=24&arq_ret=R5QT1WSRQBMCVQVPFFQSF99MCT5RT44Q9WRW0RBM0FMM5QQ4R4CV59RWRF1F5SWCW0")
//    else { return }
//
//webView.delegate = self
//webView.loadRequest(URLRequest(url: url))
