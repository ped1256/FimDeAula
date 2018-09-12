//
//  Destinys.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 12/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
enum PreDestinys: String {
    case TICAN = "Terminal de integração de Canasvieiras"
    case TISAN = "Terminal de integração de Santo Antonio de Lisboa"
    case TITRI = "Terminal de integração da Trindade"
    case TICEN = "Terminal de integração do centro"
    case TILAG = "Terminal de integração da Lagoa"
    case OTHERS = "Outro destino"
}

class Destiny: NSObject {
    var title: String
    var slug: String
    var date: Date?
    var day: String?
    
    init(title: String, slug: String) {
        self.title = title
        self.slug = slug
    }
    
    static func getPredestinys() -> [Destiny] {
        var destinys: [Destiny] = []
        destinys.append(Destiny(title: PreDestinys.TICAN.rawValue, slug: "TICAN"))
        destinys.append(Destiny(title: PreDestinys.TISAN.rawValue, slug: "TISAN"))
        destinys.append(Destiny(title: PreDestinys.TITRI.rawValue, slug: "TITRI"))
        destinys.append(Destiny(title: PreDestinys.TICEN.rawValue, slug: "TICEN"))
        destinys.append(Destiny(title: PreDestinys.TILAG.rawValue, slug: "TILAG"))
        destinys.append(Destiny(title: PreDestinys.OTHERS.rawValue, slug: "OTHERS"))
        
        return destinys
    }
}
