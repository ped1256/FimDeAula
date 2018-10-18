//
//  Utilitys.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 26/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class App: NSObject {
    func isIphoneSE() -> Bool {
        let screenRect = UIScreen.main.bounds
        if screenRect.size.height == 568 {
            return true
        } else {
            return false
        }
    }
    
    func isIphoneX() -> Bool {
        let screen = UIScreen.main.bounds
        if screen.size.height >= 812 {
            return true
        } else {
            return false
        }
    }
}

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}

class Util: NSObject {
    
    static func makeMapSnapshot(location: CLLocationCoordinate2D?, completion: @escaping (UIImage?) -> ()) {
        guard let location = location else { return }
        
        let span = MKCoordinateSpan.init(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion.init(center: location, span: span)
        
        let snapshotOptions = MKMapSnapshotter.Options()
        snapshotOptions.size = CGSize(width: UIScreen.main.bounds.width, height: 250)
        snapshotOptions.mapType = MKMapType.standard
        snapshotOptions.showsBuildings = false
        snapshotOptions.showsPointsOfInterest = false
        snapshotOptions.region = region
        
        let snapshotter = MKMapSnapshotter(options: snapshotOptions)
        snapshotter.start (completionHandler: { (snapshot, error) -> Void in
            if error == nil {
                // get the image associated with the snapshot
                let image = snapshot!.image
                
                // get the size of the final image
                let finalImageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                
                let pin = MKAnnotationView(annotation: nil, reuseIdentifier: "mapPin")
                pin.image = UIImage(named: "pin-map-black")
                let pinImage = pin.image
                
                // let's start to create our final image
                UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
                
                // first draw the image from the snapshotter
                image.draw(at: CGPoint(x: 0, y: 0))
                
                // iterate through annotations and draw
                
                var point = snapshot!.point(for: location)
                if finalImageRect.contains(point) {
                    let pinCenterOffset = pin.centerOffset
                    point.x -= (pin.bounds.size.width) / 2.0
                    point.x += (pinCenterOffset.x)
                    point.y -= (pin.bounds.size.height) / 2.0
                    point.y += (pinCenterOffset.y)
                    
                    pinImage!.draw(at: point)
                }
                
                // grab the final image
                let mapImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                completion(mapImage)
            }
        })
    }
}
