//
//  UniversityNameView.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 11/10/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class UniversityNameView: UIView {
    var faculdadeText = UILabel()
    var universityNameText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.backgroundColor = ThemeColor.shared.actionButtonSecondaryColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.addSubview(faculdadeText)
        faculdadeText.text = "FACULDADE"
        faculdadeText.translatesAutoresizingMaskIntoConstraints = false
        faculdadeText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        faculdadeText.font = UIFont.systemFont(ofSize: 24)
        faculdadeText.textColor = ThemeColor.shared.textColor
        faculdadeText.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        
        self.addSubview(universityNameText)
        universityNameText.translatesAutoresizingMaskIntoConstraints = false
        universityNameText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        universityNameText.topAnchor.constraint(equalTo: faculdadeText.bottomAnchor, constant: 10).isActive = true
        universityNameText.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        universityNameText.textColor = ThemeColor.shared.actionButtonSecondaryColor
        universityNameText.layer.cornerRadius = 5
        universityNameText.clipsToBounds = true
        universityNameText.backgroundColor = .white
        universityNameText.text = "cesusc"
    }
}
