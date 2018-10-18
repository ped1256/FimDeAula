//
//  ThemeManager.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 09/10/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ThemeManager: NSObject {
    
    let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()
    
    func start(completion: @escaping ()-> ()) {
        remoteConfiguration {
            self.fetchTheme(compeltion: {
                completion()
            })
        }
    }
    
    var actionButtonColor = UIColor(hexString: "E11F1F")
    var textColor = UIColor(hexString: "FFFFFF")
    var backgroundColor = UIColor(hexString: "000000")
    var cellBackgroundColor = UIColor(hexString: "363535")
    var cellTitleColor = UIColor(hexString: "F4F4F4")
    var modalBackgroundColor = UIColor(hexString: "7A7575")
    var tableViewBackgroundColor = UIColor(hexString: "4E4E4E")
    
}

extension ThemeManager {

    func remoteConfiguration(callback: @escaping () -> ()) {
        let settings = RemoteConfigSettings(developerModeEnabled: true)
        self.remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(completionHandler: { (status, error) in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activateFetched()
                callback()
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        })
    }
    
    func fetchTheme(compeltion: () -> ()) {
        let decoder = JSONDecoder()
        let cesuscData = remoteConfig["cesuscLayout"].dataValue
        
        do {
            let layout = try decoder.decode(Layout.self, from: cesuscData)
            ThemeColor.shared.parseTheme(layout: layout.appLayout)
            compeltion()
        } catch let error {
            print(error)
        }
    }
}
