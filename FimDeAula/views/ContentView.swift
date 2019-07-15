//
//  ContentView.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 15/07/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class ContentView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 10)
        return l
    }()
    
    var title: String? {
        didSet {
            updateUI()
        }
    }
    
    private func buildUI() {
        backgroundColor = ThemeColor.shared.actionButtonSecondaryColor
        clipsToBounds = true
        layer.cornerRadius = 5
        
        self.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func updateUI() {
        titleLabel.text = title
    }
}
