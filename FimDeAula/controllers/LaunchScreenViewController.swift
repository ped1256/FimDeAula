//
//  LaunchScreenViewController.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 08/03/19.
//  Copyright © 2019 Pedro Emanuel. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    let lineContentView = UIView()
    let lineView = UIView()
    var leftAnchorConstraint: NSLayoutConstraint?
    
    let lineViewWidth: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        buildUI()
        swipeToRight()
    }
    
    private func buildUI() {
        self.view.addSubview(lineContentView)
        lineContentView.isHidden = true
        lineContentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lineContentView.translatesAutoresizingMaskIntoConstraints = false
        lineContentView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        lineContentView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        lineContentView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        
        if App().isIphoneX() {
            lineContentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35).isActive = true
        } else {
            lineContentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }
        
        lineContentView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        lineView.isHidden = true
        lineView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: lineViewWidth).isActive = true
        lineView.topAnchor.constraint(equalTo: lineContentView.topAnchor).isActive = true
        
        leftAnchorConstraint = lineView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -15)
        leftAnchorConstraint?.isActive = true
        
        
    }
    
    private func swipeToRight(){
        self.view.setNeedsLayout()
        
        UIView.animate(withDuration: 1.0, animations: {
            let constant = UIScreen.main.bounds.width + self.lineViewWidth / 2
            self.leftAnchorConstraint?.constant = constant
            self.view.layoutIfNeeded()
        }) { finished in
            self.lineView.isHidden = false
            self.lineContentView.isHidden = false
            self.swipeToLeft()
        }
    }
    
    private func swipeToLeft() {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 1.0, animations: {
            self.leftAnchorConstraint?.constant = -(self.lineViewWidth - 30)
            self.view.layoutIfNeeded()
        }) { finished in
            self.swipeToRight()
        }
    }
}
