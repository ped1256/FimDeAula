//
//  FormViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit
enum SchedulingSection: Int {
    case days, hour, space
}

class FormViewController: UIViewController {
    
    var cellTypes: [Destiny] = Destiny.getPredestinys()
    let grayBackground = UIView()
    var titleLabel = UILabel()
    var subtitleView = UIView()
    var collectionView: UICollectionView?
    var backButtonView = UIButton()
    var cellSelectedIndex: Int = -1
    var driverInfoView = UIView()
    var sections = [SchedulingSection]()
    var user: User?
    var schedule = Schedule()
    var acceptButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
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
    }
    
    func buildUI() {
        addTitle()
        addSubtitleView()
        addbackButton()
        prepareCollectionView()
        addButtonaccept()
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
        
        subtitleTextLabel.text = "Selecione Dia e horario"
        if App().isIphoneSE() {
            subtitleTextLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        } else {
            subtitleTextLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
        
        subtitleTextLabel.textColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        subtitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleTextLabel.centerXAnchor.constraint(equalTo: subtitleView.centerXAnchor, constant: 5).isActive = true
        
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
    
    func prepareCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width, height: 42)
        layout.headerReferenceSize = layout.itemSize

        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        collectionView.register(SchedulingCollection.self, forCellWithReuseIdentifier: daysViewIdentifier)
        collectionView.register(SchedulingCollection.self, forCellWithReuseIdentifier: hourViewIdentifier)
        collectionView.register(SchedulingCollection.self, forCellWithReuseIdentifier: spaceViewIdentifier)
        
        sections.append(.days)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.subtitleView.bottomAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.backgroundColor = .clear
        
    }
    func addButtonaccept(){
        self.view.addSubview(acceptButton)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        
        acceptButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        acceptButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        acceptButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        acceptButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        acceptButton.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
        acceptButton.isHidden = true
        
        if schedule.decisionType == .driver {
            acceptButton.setTitle("Cadastrar carona", for: .normal)
        } else {
            acceptButton.setTitle("Encontrar carona", for: .normal)
        }
        
        acceptButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        acceptButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        acceptButton.addTarget(self, action: #selector(acceptAction(_:)), for: .touchUpInside)
    }
    
    @objc func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func acceptAction(_ sender: Any){
        if schedule.decisionType == .driver {
            registerRide()
        } else {
            findRider()
        }
    }
    
    func registerRide() {
        guard let user = self.user else { return }
        
        schedule.user = user
        schedule.id = UUID().uuidString
        user.schedules.append(self.schedule)
        
        let loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        loadingView.animating.startAnimating()
        
        Operation().registerScheduleInUserAccount(user: user, schedule: schedule) {
            loadingView.animating.stopAnimating()
            loadingView.removeFromSuperview()
            
            let succesRegisterView = SuccesRegisterView(frame: self.view.frame)
            succesRegisterView.buildUI()
            succesRegisterView.alpha = 0.0
            succesRegisterView.delegate = self
            self.view.addSubview(succesRegisterView)
            
            UIView.animate(withDuration: 1.5) {
                succesRegisterView.alpha = 1.0
            }
        }
    }
    
    func findRider(){
        guard let user = self.user else { return }
        
        let loadingView = LoadingView(frame: self.view.frame)
        self.view.addSubview(loadingView)
        loadingView.animating.startAnimating()
        
        Operation().retriveRides(schedule: schedule) { schedules in
            let rides = Operation().filterRides(schedule: self.schedule, rides: schedules)
            let homeRidesViewController = HomeRidesViewController()
            homeRidesViewController.rides = rides
            homeRidesViewController.user = user
            self.navigationController?.pushViewController(homeRidesViewController, animated: true)
            
            loadingView.animating.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
    
    let hourViewIdentifier = "hourViewIdentifier"
    let daysViewIdentifier = "daysViewIdentifier"
    let spaceViewIdentifier = "spaceViewIdentifier"
    
}

extension FormViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SchedulingDaysCollectionDelegate {

    func didSelectScheduling(schedulingSection: SchedulingSection, value: String) {
        switch schedulingSection {
        case .days:
            if !sections.contains(.hour) {
                sections.append(.hour)
            }
            
            self.schedule.day = value
        case .hour:
            if !sections.contains(.space) {
                sections.append(.space)
            }
            
            self.schedule.hour = value
        case .space:
            self.acceptButton.isHidden = false
            self.schedule.space = value
        }
        
        collectionView?.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let section = SchedulingSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch section {
        case .days :
            guard let schedulingDaysCollection = collectionView.dequeueReusableCell(withReuseIdentifier: daysViewIdentifier, for: indexPath) as? SchedulingCollection else { return UICollectionViewCell() }
            
            schedulingDaysCollection.delegate = self
            schedulingDaysCollection.section = .days
            cell = schedulingDaysCollection
            
        case .hour:
            guard let schedulingHourCollection = collectionView.dequeueReusableCell(withReuseIdentifier: hourViewIdentifier, for: indexPath) as? SchedulingCollection else { return UICollectionViewCell() }
            
            schedulingHourCollection.delegate = self
            schedulingHourCollection.section = .hour
            cell = schedulingHourCollection
        case .space:
            guard let schedulingSpaceCollection = collectionView.dequeueReusableCell(withReuseIdentifier: spaceViewIdentifier, for: indexPath) as? SchedulingCollection else { return UICollectionViewCell() }
            
            schedulingSpaceCollection.delegate = self
            schedulingSpaceCollection.section = .space
            cell = schedulingSpaceCollection
        }
        
        return cell
    }
}

extension FormViewController: SuccesRegisterViewDelegate {
    
    func confirmSuccessButtonDidTouch() {
        self.dismiss(animated: true, completion: nil)
    }

}
