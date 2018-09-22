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

class Operation: NSObject {

    var ref: DatabaseReference?
    
    func retrieverUserFacebookInfo(completion: @escaping (User)-> ()){
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, gender, cover, picture"])
        _ = graphRequest?.start(completionHandler: {
            (connection, result, error) -> Void in
            
            guard error == nil else { return }
            UserDefaults.standard.setValue(true, forKey: Identifier().userIsLogedIdentifier)
            guard let user = User.parseInfoFromFacebook(result: result) else { return }
            completion(user)
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
        
        ref?.child("rides/\(schedule.id)").setValue(scheduleInfo)
    }
    
    func registerOnlyUser(user: User){
        ref = Database.database().reference()
        
        var userInfo = [String: Any]()
        userInfo["name"] = user.name
        userInfo["id"] = user.id
        userInfo["email"] = user.email ?? ""
        userInfo["picturePath"] = user.picturePath
        
        let schedulesInfo = [[String: Any]]()
        userInfo["schedules"] = schedulesInfo
        
        ref?.child("user/\(user.id)").setValue(userInfo)
    }
    
    func getUserInfo(id: String, completion: @escaping (User) -> ()) {
        ref = Database.database().reference()
        ref?.child("user/\(id)").queryOrderedByValue().observeSingleEvent(of: .value) { snapshot  in
            guard let data = snapshot.value as? [String: AnyObject] else { return }
            guard let name = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let email = data["email"] as? String else  { return }
            guard let picturePath = data["picturePath"] as? String else { return }
            
            let user = User(name: name, id: id)
            user.email = email
            user.picturePath = picturePath
            completion(user)
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
        
        ref?.child("user/\(user.id)/schedules/\(schedule.id)").setValue(scheduleInfo)
        self.registerOnlyRideSchedules(schedule: schedule)
    }
    
    func addUserPhoneNumber(user: User, value: String){
        ref = Database.database().reference()
        ref?.child("user/\(user.id)/userPhone").setValue(value)
    }
    
    func retriveFilteredRides(schedule: Schedule, completion: @escaping (([Schedule]) ->() )) {
        ref = Database.database().reference()
        ref?.child("rides").queryOrderedByValue().observeSingleEvent(of: .value) { snapshot  in
            guard let data = snapshot.value as? [String: Any] else { return }
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
                guard let userId = scheduleData["userId"] as? String else { return }
                
                let schedule = Schedule()
                schedule.day = day
                schedule.destiny = Destiny(title: title, slug: slug)
                schedule.hour = hour
                schedule.id = id
                schedule.space = space
                schedule.user = User(name: "", id: userId)
                schedules.append(schedule)
            }
            
            completion(schedules)
        }
    }
}
