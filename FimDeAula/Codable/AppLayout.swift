//
//  AppLayout.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 09/10/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation

struct Layout: Codable {
    var appLayout: AppLayout
}

struct AppLayout: Codable {
    var actionButtonColor: String
    var textColor: String
    var backgroundColor: String
    var cellBackgroundColor: String
    var cellTitleColor: String
    var modalBackgroundColor: String
    var tableViewBackgroundColor: String
    var actionButtonSecondaryColor: String
    var secondaryTextColor: String
}
