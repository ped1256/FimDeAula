//
//  AccountTableViewDelegate.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 26/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

class AccountTableViewDelegate: NSObject, UITableViewDelegate {
    var tableView: UITableView?
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
