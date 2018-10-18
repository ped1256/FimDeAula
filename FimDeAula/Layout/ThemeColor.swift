//
//  ThemeColor.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 09/10/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class ThemeColor: NSObject {
 
    static var shared = ThemeColor()
    
    func parseTheme(layout: AppLayout) {
        actionButtonColor = UIColor(hexString: layout.actionButtonColor)
        textColor = UIColor(hexString: layout.textColor)
        backgroundColor = UIColor(hexString: layout.backgroundColor)
        cellBackgroundColor = UIColor(hexString: layout.cellBackgroundColor)
        cellTitleColor = UIColor(hexString: layout.cellTitleColor)
        modalBackgroundColor = UIColor(hexString: layout.modalBackgroundColor)
        tableViewBackgroundColor = UIColor(hexString: layout.tableViewBackgroundColor)
        actionButtonSecondaryColor = UIColor(hexString: layout.actionButtonSecondaryColor)
        secondaryTextColor = UIColor(hexString: layout.secondaryTextColor)
    }
    
    var actionButtonColor = UIColor.clear
    var textColor = UIColor.clear
    var backgroundColor = UIColor.clear
    var cellBackgroundColor = UIColor.clear
    var cellTitleColor = UIColor.clear
    var modalBackgroundColor = UIColor.clear
    var tableViewBackgroundColor = UIColor.clear
    var actionButtonSecondaryColor = UIColor.clear
    var secondaryTextColor = UIColor.clear
}
