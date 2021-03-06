//
//  Schedule.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 20/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Schedule: NSObject {
    var destiny = Destiny(title: DestinysText.OTHERS.rawValue, slug: "OTHERS", location: nil)
    var decisionType: DecisionType = .driver
    var hour: String = ""
    var space: String = "1"
    var day: String = ""
    var user: User?
    var id = ""
    
    func isEmpty() -> Bool {
       return self.day.isEmpty
    }
}
