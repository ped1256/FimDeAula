//
//  AccountViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 25/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    
    var user: User?
    var schedules: [Schedule]?
    let backImageview = UIImageView()
    let userInfoBackground = UIView()
    let userImageView = UIImageView()
    let userNameTitle = UILabel()
    let ridesTitle = UILabel()
    let horizontalLineView = UIView()
    let backButton = UIButton()
    
    let scrollView = UIScrollView()
    let tableView = UITableView()
    
    let accountTableViewDelegate = AccountTableViewDelegate()
    
    var userInfoBackgroundTopConstraint: NSLayoutConstraint!
    var horizontalLineViewTopContraint: NSLayoutConstraint!
    var userInfoBackgroundAnimator: UIViewPropertyAnimator!
    var userimageViewAnimator: UIViewPropertyAnimator!
    var ridesTitleAnimator: UIViewPropertyAnimator!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        buildLayout()
    }
    
    func buildLayout(){
        buildUserBackImage()
        buildUserInfoBackground()
        buildScrollview()
        builUserInfo()
        buildRidesTitles()
        buildTableView()
        buildBackButton()
        
        guard let user = self.user else { return }
        
        Operation().getUserSchedules(id: user.id) { schedules in
            self.schedules = schedules
            self.tableView.reloadData()
        }
    }
    
    func buildUserBackImage(){
        self.view.addSubview(backImageview)
        backImageview.translatesAutoresizingMaskIntoConstraints = false
        
        backImageview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        backImageview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        backImageview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backImageview.heightAnchor.constraint(equalToConstant: self.view.frame.height / 2).isActive = true
        backImageview.image = #imageLiteral(resourceName: "userBackImageDefault")
        backImageview.makeBlurImage(targetImageView: backImageview, style: .regular)

    }
    
    func buildBackButton(){
        self.scrollView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.backImageview.leftAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: self.backImageview.topAnchor, constant: 25).isActive = true
        backButton.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 20
        backButton.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
    }
    
    func buildUserInfoBackground(){
        self.view.addSubview(userInfoBackground)
        
        userInfoBackground.translatesAutoresizingMaskIntoConstraints = false
        userInfoBackgroundTopConstraint = userInfoBackground.topAnchor.constraint(equalTo: backImageview.bottomAnchor, constant: -30)
        userInfoBackgroundTopConstraint.isActive = true
        userInfoBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        userInfoBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        userInfoBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 30).isActive = true
        userInfoBackground.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        userInfoBackground.layer.cornerRadius = 30
        userInfoBackground.clipsToBounds = true
        
        let dragSinalizerview = UIView()
        userInfoBackground.addSubview(dragSinalizerview)
        dragSinalizerview.translatesAutoresizingMaskIntoConstraints = false
        dragSinalizerview.heightAnchor.constraint(equalToConstant: 6).isActive = true
        if App().isIphoneSE() {
            dragSinalizerview.widthAnchor.constraint(equalToConstant: 40).isActive = true
        } else {
          dragSinalizerview.widthAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        dragSinalizerview.centerXAnchor.constraint(equalTo: userInfoBackground.centerXAnchor).isActive = true
        dragSinalizerview.topAnchor.constraint(equalTo: userInfoBackground.topAnchor, constant: 10).isActive = true
        dragSinalizerview.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        dragSinalizerview.clipsToBounds = true
        dragSinalizerview.layer.cornerRadius = 3
        userInfoBackgroundAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.userInfoBackground.layer.cornerRadius = 0
        }
    }
    
    func buildScrollview(){
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: userInfoBackground.topAnchor, constant: 30).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 450)
        scrollView.backgroundColor = .clear
    }
    
    func builUserInfo(){
        self.view.addSubview(userImageView)
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.heightAnchor.constraint(equalToConstant: 124).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 124).isActive = true
        userImageView.centerYAnchor.constraint(equalTo: userInfoBackground.topAnchor, constant: 0).isActive = true
        
        if App().isIphoneSE() {
            userImageView.leftAnchor.constraint(equalTo: userInfoBackground.leftAnchor, constant: 10).isActive = true
        } else {
            userImageView.leftAnchor.constraint(equalTo: userInfoBackground.leftAnchor, constant: 25).isActive = true
        }
        
        userImageView.clipsToBounds = true
        userImageView.backgroundColor = .black
        userImageView.layer.cornerRadius = 62
        userImageView.image = user?.picture
        
        userimageViewAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.userImageView.alpha = 0.0
            self.userImageView.layer.cornerRadius = 20
        }
        
        userInfoBackground.addSubview(userNameTitle)
        userNameTitle.translatesAutoresizingMaskIntoConstraints = false
        userNameTitle.leftAnchor.constraint(equalTo: userInfoBackground.leftAnchor,constant: 20).isActive = true
        userNameTitle.rightAnchor.constraint(equalTo: userInfoBackground.rightAnchor, constant: -20).isActive = true
        userNameTitle.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10).isActive = true
        userNameTitle.text = self.user?.name
        userNameTitle.font = UIFont.systemFont(ofSize: 20)
        userNameTitle.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
    }

    func buildRidesTitles(){
        userInfoBackground.addSubview(ridesTitle)
        ridesTitle.translatesAutoresizingMaskIntoConstraints = false
        ridesTitle.leftAnchor.constraint(equalTo: userInfoBackground.leftAnchor, constant: 20).isActive = true
        ridesTitle.topAnchor.constraint(equalTo: userNameTitle.bottomAnchor, constant: 40).isActive = true
        ridesTitle.text = "Suas caronas"
        ridesTitle.font = UIFont.systemFont(ofSize: 25)
        ridesTitle.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        
        ridesTitleAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.ridesTitle.alpha = 0.0
            self.userNameTitle.alpha = 0.0
        }
        
        self.userInfoBackground.addSubview(horizontalLineView)
        horizontalLineView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalLineView.leftAnchor.constraint(equalTo: userInfoBackground.leftAnchor).isActive = true
        horizontalLineView.rightAnchor.constraint(equalTo: userInfoBackground.rightAnchor).isActive = true
        horizontalLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalLineViewTopContraint = horizontalLineView.topAnchor.constraint(equalTo: ridesTitle.bottomAnchor, constant: 10)
        horizontalLineViewTopContraint.isActive = true

        horizontalLineView.backgroundColor = .clear
    }
    
    func buildTableView() {
        self.userInfoBackground.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: userInfoBackground.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: userInfoBackground.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: horizontalLineView.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: userInfoBackground.bottomAnchor).isActive = true
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.delegate = accountTableViewDelegate
        tableView.dataSource = self
        
        tableView.register(AccountRideCell.self, forCellReuseIdentifier: AccountRideCell.identifier)
    }
    
    @objc func backAction(_ sender: Any){
        self.userInfoBackgroundAnimator.stopAnimation(true)
        self.ridesTitleAnimator.stopAnimation(true)
        self.userimageViewAnimator.stopAnimation(true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource, AccounRideCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let schedules = self.schedules else { return 0 }
        return schedules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountRideCell.identifier, for: indexPath) as? AccountRideCell else { return UITableViewCell() }
        if let schedule = self.schedules?[indexPath.row] {
            cell.schedule = schedule
            cell.buildUI()
        }
        
        cell.delegate = self
        return cell
    }

    func didTouchInRemoveButton(schedule: Schedule) {
        
        let alertController = UIAlertController()
        
        let confirmAction = UIAlertAction(title: "Remover", style: .default, handler: { action in
            guard let user = self.user else { return }
            Operation().removeScheduleInUserAccount(user: user, schedule: schedule, completion: {
                Operation().getUserSchedules(id: user.id, completion: { schedules in
                    self.schedules = schedules
                    self.tableView.reloadData()
                })
            })
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}

extension AccountViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // refactor this on future
        var value = scrollView.contentOffset.y
        // value adjuste the  precision of contentOffset.y
        value += 50
        
        if value > 30 && value < 230 {
            userInfoBackgroundTopConstraint.constant = -value
        }

        // value adjust the precision of contentOffset.y
        value -= 50

        var horizoltanViewTopConstant: CGFloat = 30
        
        if !App().isIphoneSE() {
            horizoltanViewTopConstant = 0
        }
        
        if value < 130 && value > horizoltanViewTopConstant {
            self.horizontalLineViewTopContraint.constant = -value
        } else if value > 0 && value < horizoltanViewTopConstant {
            self.horizontalLineViewTopContraint.constant = value
        }
        
        self.userInfoBackgroundAnimator.fractionComplete = value / 100 / 3
        self.userimageViewAnimator.fractionComplete = value / 100 / 2
        self.ridesTitleAnimator.fractionComplete = value / 100 / 2
    }
}
