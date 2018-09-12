//
//  LoadingView.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    let animating = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let topViewIndicator = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() {
        self.addSubview(topViewIndicator)
        topViewIndicator.frame = self.frame
        topViewIndicator.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 1.0) {
            self.topViewIndicator.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        }
        
        animating.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animating.center = self.center
        animating.hidesWhenStopped = true
        topViewIndicator.addSubview(animating)
    }
    
    func start(completion: @escaping () -> ()) {
        self.animating.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.animating.stopAnimating()
            self.topViewIndicator.removeFromSuperview()
            completion()
        }
    }
}
