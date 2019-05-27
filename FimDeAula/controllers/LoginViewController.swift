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
 
    private var loginButton = UIButton()
    private var logginButtonWidthContraint: NSLayoutConstraint?
    private var logginButtonheightContraint: NSLayoutConstraint?
    private var logginButtonBottomContraint: NSLayoutConstraint?

    private var modalView = UIView()
    private var darkBackgroundView = UIView(frame: UIScreen.main.bounds)
    private var titleLabel = UILabel()
    private var logoImageView = UIImageView()
    private var messageLabel = UILabel()
    
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.delegate = self
        webView.isHidden = true
        webView.alpha = 0.0
        webView.clipsToBounds = true
        webView.layer.cornerRadius = 10
        webView.backgroundColor = ThemeColor.shared.modalBackgroundColor
        
        return webView
    }()
    
    private lazy var acessorySpinner: SpinnerView = {
        let spinner = SpinnerView(frame: .zero)
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
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
        
        buildBackModalView()
        
        buildTitle()
        buildMessage()
        buildButton()
        buildBackgroundView()
        buildWebView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildBackModalView() {
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
    
    func buildTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.text = "Fim de aula"
        titleLabel.textColor = ThemeColor.shared.textColor
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
    }
    
    func buildMessage(){
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
    
    private func buildButton() {
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.backgroundColor = ThemeColor.shared.actionButtonColor
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        loginButton.setTitle("Entrar", for: .normal)
        
        logginButtonWidthContraint = loginButton.widthAnchor.constraint(equalToConstant: 260)
        logginButtonWidthContraint?.isActive = true
        logginButtonheightContraint = loginButton.heightAnchor.constraint(equalToConstant: 60)
        logginButtonheightContraint?.isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logginButtonBottomContraint = loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100)
        logginButtonBottomContraint?.isActive = true
        
        loginButton.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        
        loginButton.addSubview(acessorySpinner)
        acessorySpinner.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        acessorySpinner.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
        acessorySpinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        acessorySpinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func buildBackgroundView() {
        self.view.addSubview(darkBackgroundView)
        darkBackgroundView.isHidden = true
        darkBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
    }
    
    private func buildWebView() {
        self.view.addSubview(webView)
        webView.leftAnchor.constraint(equalTo: modalView.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: modalView.rightAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: modalView.topAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: modalView.heightAnchor).isActive = true
    }
    
    @objc private func loginAction(_ sender: Any) {
        guard let request = AuthOperation().request() else { return }
        
        webView.loadRequest(request)
        showWebViewWithAnimate()
        startButtonAnimation()
        
    }
    
    private func showWebViewWithAnimate(){
        webView.isHidden = false
        darkBackgroundView.isHidden = false
        
        UIView.animate(withDuration: 1.5) {
            self.darkBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            self.webView.alpha = 1.0
        }
    }
    
    private func removeWebViewWithAnimate() {
        UIView.animate(withDuration: 0.5, animations: {
            self.webView.alpha = 0
            self.darkBackgroundView.alpha = 0
        
        }) { finished in
            self.webView.isHidden = true
            self.darkBackgroundView.isHidden = true
            self.finishButtonAnimation()
        }
    }
    
    private func startButtonAnimation() {
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 1.0) {
            self.logginButtonWidthContraint?.constant = 60
            self.loginButton.setTitle("", for: .normal)
            self.loginButton.layer.cornerRadius = 30
            self.acessorySpinner.state = .spinning
            self.acessorySpinner.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func finishButtonAnimation() {
        acessorySpinner.state = .idle

        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.4, animations: {
            self.logginButtonWidthContraint?.constant = UIScreen.main.bounds.width
            self.logginButtonheightContraint?.constant = UIScreen.main.bounds.height
            self.loginButton.layer.cornerRadius = 0
            self.loginButton.backgroundColor = ThemeColor.shared.modalBackgroundColor
            self.logginButtonBottomContraint?.constant = 0
            
            self.view.layoutIfNeeded()
        }) { finished in
            // present view here
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.navigationController?.present(UserInfoFormViewController(), animated: false, completion: {
                    self.loginButton.isHidden = true
                })
                
            })
        }
    }
    
}

extension LoginViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = webView.request?.url else { return true }
        
        AuthOperation().processLogin(url: url, completion: {
            UserDefaults.standard.setValue(true, forKey: Identifier().userIsAuthenticatedIdentifier)
            self.removeWebViewWithAnimate()
        })
        
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        removeWebViewWithAnimate()
    }
}


//extension LoginViewController: FBSDKLoginButtonDelegate {
//    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
//        UserDefaults.standard.setValue(false, forKey: Identifier().userIsLogedIdentifier)
//    }
//
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        Operation().retrieverUserFacebookInfo { user in
//            DispatchQueue.main.async {
//                let chooseGoalViewController = ChooseGoalViewController()
//                chooseGoalViewController.user = user
//                Operation().registerOnlyUser(user: user)
//                self.navigationController?.pushViewController(chooseGoalViewController, animated: true)
//            }
//        }
//    }
//}
