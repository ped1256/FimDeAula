//
//  DestinyContentView.swift
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
    
    var title: String? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 10)
        l.textColor = .white
        return l
    }()

    private lazy var contenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ThemeColor.shared.actionButtonSecondaryColor
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        view.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return view
    }()
    
    private func buildUI() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 5
        addSubview(contenView)
        addSubview(titleLabel)
        contenView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contenView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: contenView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contenView.centerYAnchor).isActive = true
    }
    
    private func updateUI() {
        titleLabel.text = title
    }
}
