//
//  Operation.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 21/09/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import Firebase
import CoreLocation

class Operation: NSObject {

    var ref: DatabaseReference?
    
    func retrieverUserFacebookInfo(completion: @escaping (User)-> ()){
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, gender, cover, picture"])
        _ = graphRequest?.start(completionHandler: {
            (connection, result, error) -> Void in
            guard error == nil else { return }
            UserDefaults.standard.setValue(true, forKey: Identifier().userIsLogedIdentifier)
            
            User.parseInfoFromFacebook(result: result, completion: { user in
                completion(user)
            })
        })
    }
    
    func registerOnlyRideSchedules(schedule: Schedule){
        ref = Database.database().reference()
        
        var scheduleInfo = [String: Any]()
        scheduleInfo["id"] = schedule.id
        scheduleInfo["destinyTitle"] = schedule.destiny.title
        scheduleInfo["destinySlug"] = schedule.destiny.slug
        scheduleInfo["space"] = schedule.space
        scheduleInfo["hour"] = schedule.hour
        scheduleInfo["day"] = schedule.day
        scheduleInfo["userId"] = schedule.user?.id
        scheduleInfo["driverName"] = schedule.user?.name

        var destinyLocation = [String: Any]()
        destinyLocation["lat"] = schedule.destiny.location?.latitude
        destinyLocation["long"] = schedule.destiny.location?.longitude

        scheduleInfo["destinyLocation"] = destinyLocation
        
        ref?.child("rides/\(schedule.id)").setValue(scheduleInfo)
    }
    
    func userIsRegistered(user: User, completion: @escaping (Bool) -> ()) {
        self.getUserInfo(id: user.id) { user in
            if user != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func registerOnlyUser(user: User){
        userIsRegistered(user: user) { isRegistered in
            guard !isRegistered else { return }
            
            self.ref = Database.database().reference()
            
            var userInfo = [String: Any]()
            userInfo["name"] = user.name
            userInfo["id"] = user.id
            userInfo["email"] = user.email ?? ""
            userInfo["picturePath"] = user.picturePath
            userInfo["userPhone"] = user.phoneNumber
            
            let schedulesInfo = [[String: Any]]()
            userInfo["schedules"] = schedulesInfo
            
            self.ref?.child("user/\(user.id)").setValue(userInfo)
        }
    }
    
    func getUserSchedules(id: String, completion: @escaping ([Schedule]) -> ()) {
        ref = Database.database().reference()
        ref?.child("user/\(id)/schedules").queryOrderedByValue().observeSingleEvent(of: .value) { snapshot  in
            guard let data = snapshot.value as? [String: AnyObject] else {
                completion([Schedule]())
                return
            }
            var schedules = [Schedule]()
            
            for response in data {
                let scheduleresponse = response.value
                guard let scheduleData = scheduleresponse as? [String: AnyObject] else { return }
                guard let day = scheduleData["day"] as? String else { return }
                guard let slug = scheduleData["destinySlug"] as? String else { return }
                guard let title = scheduleData["destinyTitle"] as? String else { return }
                guard let hour = scheduleData["hour"] as? String else { return }
                guard let id = scheduleData["id"] as? String else { return }
                guard let space = scheduleData["space"] as? String else { return }
                guard let driverName = scheduleData["driverName"] as? String else { return }
                guard let userId = scheduleData["userId"] as? String else { return }
                guard let destinyLocation = scheduleData["destinyLocation"] as? [String: Any] else { return }
                guard let lat = destinyLocation["lat"] as? Double else { return }
                guard let long = destinyLocation["long"] as? Double else { return }
                
                let schedule = Schedule()
                schedule.day = day
                let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
                schedule.destiny = Destiny(title: title, slug: slug, location: location)
                schedule.hour = hour
                schedule.id = id
                schedule.space = space
                schedule.user = User(name: driverName, id: userId)
                schedules.append(schedule)
            }
            completion(schedules)
        }
    }
    
    func getUserInfo(id: String, completion: @escaping (User?) -> ()) {
        ref = Database.database().reference()
        ref?.child("user/\(id)").queryOrderedByValue().observeSingleEvent(of: .value) { snapshot  in
            guard let data = snapshot.value as? [String: AnyObject] else {
                completion(nil)
                return
            }

            guard let name = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let email = data["email"] as? String else  { return }
            let phone = data["userPhone"] as? String ?? ""
            
            let user = User(name: name, id: id)
            user.email = email
            user.phoneNumber = phone
            user.picturePath = "http://graph.facebook.com/\(user.id)/picture?type=large"
            user.parseImage {
                completion(user)
            }
        }
    }
    
    func registerScheduleInUserAccount(user: User, schedule: Schedule, completion: @escaping () -> ()){
        ref = Database.database().reference()
        var scheduleInfo = [String: Any]()
        
        scheduleInfo["id"] = schedule.id
        scheduleInfo["destinyTitle"] = schedule.destiny.title
        scheduleInfo["destinySlug"] = schedule.destiny.slug
        scheduleInfo["space"] = schedule.space
        scheduleInfo["hour"] = schedule.hour
        scheduleInfo["day"] = schedule.day
        scheduleInfo["userId"] = schedule.user?.id
        scheduleInfo["driverName"] = user.name
        
        var destinyLocation = [String: Any]()
        destinyLocation["lat"] = schedule.destiny.location?.latitude
        destinyLocation["long"] = schedule.destiny.location?.longitude
        
        scheduleInfo["destinyLocation"] = destinyLocation
        
        ref?.child("user/\(user.id)/schedules/\(schedule.id)").setValue(scheduleInfo)
        self.registerOnlyRideSchedules(schedule: schedule)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            completion()
        }
    }

    func removeScheduleInUserAccount(user: User, schedule: Schedule, completion: @escaping () -> ()){
        ref = Database.database().reference()
        ref?.child("user/\(user.id)/schedules/\(schedule.id)").removeValue()
        ref?.child("rides/\(schedule.id)").removeValue()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            completion()
        }
    }
    
    func addUserPhoneNumber(user: User, value: String){
        ref = Database.database().reference()
        ref?.child("user/\(user.id)/userPhone").setValue(value)
    }
    
    func retriveRides(schedule: Schedule, completion: @escaping (([Schedule]) ->() )) {
        ref = Database.database().reference()
        ref?.child("rides").queryOrderedByValue().observeSingleEvent(of: .value) { snapshot  in
            guard let data = snapshot.value as? [String: Any] else {
                completion([Schedule]())
                return
            }
            
            var schedules = [Schedule]()
            
            for response in data {
                let scheduleresponse = response.value
                guard let scheduleData = scheduleresponse as? [String: AnyObject] else { return }
                guard let day = scheduleData["day"] as? String else { return }
                guard let slug = scheduleData["destinySlug"] as? String else { return }
                guard let title = scheduleData["destinyTitle"] as? String else { return }
                guard let hour = scheduleData["hour"] as? String else { return }
                guard let id = scheduleData["id"] as? String else { return }
                guard let space = scheduleData["space"] as? String else { return }
                guard let driverName = scheduleData["driverName"] as? String else { return }
                guard let userId = scheduleData["userId"] as? String else { return }
                guard let destinyLocation = scheduleData["destinyLocation"] as? [String: Any] else { return }
                guard let lat = destinyLocation["lat"] as? Double else { return }
                guard let long = destinyLocation["long"] as? Double else { return }
                
                let schedule = Schedule()
                schedule.day = day
                let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
                schedule.destiny = Destiny(title: title, slug: slug, location: location)
                schedule.hour = hour
                schedule.id = id
                schedule.space = space
                schedule.user = User(name: driverName, id: userId)
                schedules.append(schedule)
            }
            
            completion(schedules)
        }
    }
    
    func filterRides(schedule: Schedule, rides: [Schedule]) -> [Schedule] {
        
        var ordenedRides = [Schedule]()
        
        let ordenedRidesOptional = rides.map { ride -> Schedule? in
            if ride.destiny.slug == schedule.destiny.slug {
                return ride
            }
            return nil
        }
        
        for ride in ordenedRidesOptional {
            if let ride = ride {
                ordenedRides.append(ride)
            }
        }
        
        return ordenedRides
    }
}
