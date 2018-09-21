//
//  Schedule.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 20/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation

class Schedule: NSObject {
    var destiny = Destiny(title: PreDestinys.OTHERS.rawValue, slug: "OTHERS")
    var decisionType: DecisionType = .driver
    var hour: String = ""
    var space: String = "1"
    var day: String = ""
    
    func isEmpty() -> Bool {
       return self.day.isEmpty
    }
}
