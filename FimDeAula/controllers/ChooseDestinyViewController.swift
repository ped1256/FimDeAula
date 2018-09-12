//
//  ChooseDestinyViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class ChooseDestinyViewController: UIViewController {
    
    var cellTypes: [Destiny] = Destiny.getPredestinys()
    let grayBackground = UIView()
    var titleLabel = UILabel()
    var subtitleView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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
    func addSubtitleView() {
        self.view.addSubview(subtitleView)
        subtitleView.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.2, blue: 0.2, alpha: 1)
        subtitleView.translatesAutoresizingMaskIntoConstraints = false
        subtitleView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        subtitleView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100).isActive = true
        subtitleView.topAnchor.constraint(equalTo: self.grayBackground.topAnchor, constant: 30).isActive = true
        subtitleView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}

//MARK: table view Delegates
extension ChooseDestinyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
