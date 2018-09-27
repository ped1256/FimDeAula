//
//  HomeRidesViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 22/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class HomeRidesViewController: UIViewController {
    
    var rides = [Schedule]()
    var decisionType: DecisionType = .passenger
    var user: User?
    let grayBackground = UIView()
    var titleLabel = UILabel()
    var subtitleView = UIView()
    var tableview = UITableView()
    var backButtonView = UIButton()
    var cellSelectedIndex: Int = -1
    
    var nav = AppNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        let backgroundView = BackgroundViewWithAnimate(frame: self.view.frame)
        
        backgroundView.addSubview(grayBackground)
        grayBackground.modalStyle()
        grayBackground.layer.cornerRadius = 0
        grayBackground.translatesAutoresizingMaskIntoConstraints = false
        grayBackground.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        grayBackground.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        grayBackground.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        grayBackground.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 80).isActive = true
        
        self.view.addSubview(backgroundView)
        self.buildUI()
        self.configureTableView()
    }
    
    func buildUI() {
        addTitle()
        addSubtitleView()
        addbackButton()
    }
    
    func addTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.text = "Fim de aula"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
    }
    func addSubtitleView() {
        self.view.addSubview(subtitleView)
        subtitleView.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.2, blue: 0.2, alpha: 1)
        subtitleView.translatesAutoresizingMaskIntoConstraints = false
        subtitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -10).isActive = true
        subtitleView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100).isActive = true
        subtitleView.topAnchor.constraint(equalTo: self.grayBackground.topAnchor, constant: 30).isActive = true
        subtitleView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        subtitleView.clipsToBounds = true
        subtitleView.layer.cornerRadius = 9
        
        let subtitleTextLabel = UILabel()
        subtitleView.addSubview(subtitleTextLabel)
        
        subtitleTextLabel.text = "Lista de Caronas"
        subtitleTextLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        subtitleTextLabel.textColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        subtitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleTextLabel.centerXAnchor.constraint(equalTo: subtitleView.centerXAnchor, constant: -10).isActive = true
        subtitleTextLabel.centerYAnchor.constraint(equalTo: subtitleView.centerYAnchor).isActive = true
    }
    
    func addbackButton() {
        self.view.addSubview(backButtonView)
        
        backButtonView.translatesAutoresizingMaskIntoConstraints = false
        backButtonView.setImage(#imageLiteral(resourceName: "backButton"), for: .normal)
        backButtonView.heightAnchor.constraint(equalToConstant: 29).isActive = true
        backButtonView.widthAnchor.constraint(equalToConstant: 29).isActive = true
        backButtonView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        backButtonView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        backButtonView.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func backAction(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: table view Delegates
extension HomeRidesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        self.view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.tableFooterView = UIView()
        tableview.backgroundColor = .clear
        tableview.separatorColor = #colorLiteral(red: 0.3058823529, green: 0.3058823529, blue: 0.3058823529, alpha: 1)
        tableview.allowsSelection = true
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableview.topAnchor.constraint(equalTo: self.subtitleView.bottomAnchor, constant: 33).isActive = true
        
        tableview.register(HomeRideCell.self, forCellReuseIdentifier: HomeRideCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let schedule = self.rides[indexPath.row]
        
        let rideInfo = RideInfoView(frame: self.view.frame)
        rideInfo.schedule = schedule
        rideInfo.buildUI()
        self.view.addSubview(rideInfo)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeRideCell.identifier, for: indexPath) as? HomeRideCell else { return UITableViewCell() }
        cell.ride = self.rides[indexPath.row]
        
        return cell
    }
}
