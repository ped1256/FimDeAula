//
//  Destinys.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import CoreLocation

enum PreDestinys: Int {
    case TICAN = 0
    case TISAN = 1
    case TITRI = 2
    case TICEN = 3
    case TILAG = 4
    case OTHERS = 5
}

enum DestinysText: String {
    case TICAN = "Terminal de integração de Canasvieiras"
    case TISAN = "Terminal de integração de Santo Antonio de Lisboa"
    case TITRI = "Terminal de integração da Trindade"
    case TICEN = "Terminal de integração do centro"
    case TILAG = "Terminal de integração da Lagoa"
    case OTHERS = "Outro destino"
}

enum DecisionType: Int {
    case driver = 0
    case passenger = 1
}

class Destiny: NSObject {
    var title: String
    var slug: String
    var location: CLLocationCoordinate2D?
    
    init(title: String, slug: String, location: CLLocationCoordinate2D?) {
        self.title = title
        self.slug = slug
        self.location = location
    }
    
    static func getPredestinys() -> [Destiny] {
        var destinys: [Destiny] = []

        destinys.append(Destiny(title: DestinysText.TICAN.rawValue, slug: "TICAN", location: DefaultDestinyLocation.ticanLocation))
        destinys.append(Destiny(title: DestinysText.TISAN.rawValue, slug: "TISAN", location: DefaultDestinyLocation.tisanLocation))
        destinys.append(Destiny(title: DestinysText.TITRI.rawValue, slug: "TITRI", location: DefaultDestinyLocation.titriLocation))
        destinys.append(Destiny(title: DestinysText.TICEN.rawValue, slug: "TICEN", location: DefaultDestinyLocation.ticenLocation))
        destinys.append(Destiny(title: DestinysText.TILAG.rawValue, slug: "TILAG", location: DefaultDestinyLocation.tilagLocation))
        destinys.append(Destiny(title: DestinysText.OTHERS.rawValue, slug: "OUTRO", location: DefaultDestinyLocation.othersLocation))
        
        return destinys
    }
}
