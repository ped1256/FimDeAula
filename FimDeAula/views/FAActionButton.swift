//
//  FAActionButton.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 19/10/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class FAActionButtom: UIButton {
    
    enum Status {
        case loading
        case loaded
    }

    private var animating = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    private var loadingView: LoadingView = LoadingView()
    private var buttonTitleText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLoadingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildLoadingView() {
        self.addSubview(animating)
    
        animating.translatesAutoresizingMaskIntoConstraints = false
        animating.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        animating.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        animating.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        animating.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    var status: Status = .loaded {
        didSet {
            updateButtonStatus()
        }
    }
    
    private func updateButtonStatus() {
        switch status {
        case .loaded:
            animating.stopAnimating()
            self.setTitle(buttonTitleText, for: .normal)
            self.alpha = 1.0
        case .loading:
            animating.startAnimating()
            buttonTitleText = self.titleLabel?.text ?? ""
            self.setTitle("", for: .normal)
            self.alpha = 0.5
        }
    }
}
