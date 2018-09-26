//
//  UIView+.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 11/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func modalStyle(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        self.alpha = 0.7
    }
    
    // for oppen wpp
//    let urlWhats = "whatsapp://send?phone=+919789384445&abid=12354&text=Hello"
//    if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//        if let whatsappURL = URL(string: urlString) {
//            if UIApplication.shared.canOpenURL(whatsappURL!) {
//                UIApplication.shared.openURL(whatsappURL!)
//            } else {
//                print("Install Whatsapp")
//            }
//        }
//    }
    
    // for call
//    if let url = URL(string: "tel://\(busPhone)"), UIApplication.shared.canOpenURL(url) {
//    if #available(iOS 10, *) {
//    UIApplication.shared.open(url)
//    } else {
//    UIApplication.shared.openURL(url)
//    }
//    }
    func makeBlurImage(targetImageView: UIView) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        targetImageView.addSubview(blurEffectView)
    }
}
