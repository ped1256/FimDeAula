//
//  DestinyLocation.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 18/10/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import CoreLocation

class DefaultDestinyLocation: NSObject {
    
    static var ticanLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Lat.TICAN.rawValue, longitude: Long.TICAN.rawValue)
    static var tisanLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Lat.TISAN.rawValue, longitude: Long.TISAN.rawValue)
    static var titriLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Lat.TITRI.rawValue, longitude: Long.TITRI.rawValue)
    static var ticenLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Lat.TICEN.rawValue, longitude: Long.TICEN.rawValue)
    static var tilagLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Lat.TILAG.rawValue, longitude: Long.TILAG.rawValue)
    static var othersLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: Lat.OTHERS.rawValue, longitude: Long.OTHERS.rawValue)
}

extension DefaultDestinyLocation {
    enum Lat: Double {
        case TICAN = -27.451478
        case TISAN = -27.501702
        case TITRI = -27.583850
        case TICEN = -27.598355
        case TILAG = -27.602842
        case OTHERS = 0
    }
    
    enum Long: Double {
        case TICAN = -48.455842
        case TISAN = -48.514739
        case TITRI = -48.522951
        case TICEN = -48.553569
        case TILAG = -48.470304
        case OTHERS = 0
    }
}
