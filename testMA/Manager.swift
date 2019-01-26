//
//  Manager.swift
//  testMA
//
//  Created by Adadémey Marvin on 25/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Manager: NSObject {
    static let instance = Manager()
    
    private func getGroupsIDs(datas: @escaping ([String]?,Error?) -> ()){
        Alamofire.request("\(Constants.baseURL)/achievements/groups", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result{
                case.success(let value):
                    datas(value as? [String], nil)
                case.failure(let error):
                    datas(nil,error)
                }
                
        }
        
        
    }
    
    func getGroups(datas: @escaping ([Group]?,Error?) -> ()){
        var groups = [Group]()
        getGroupsIDs { (receivedGroupsIDs, error) in
            if error == nil{
                if let joinedGroupsIDs = receivedGroupsIDs?.joined(separator: ","){
                    let parameters = [
                        "ids":joinedGroupsIDs,
                        ]
                    Alamofire.request("\(Constants.baseURL)/achievements/groups", method: .get, parameters: parameters)
                        .validate(statusCode: 200..<300)
                        .responseJSON { response in 
                            switch response.result{
                            case.success(let value):
                                let receivedGroups = value as! [[String:Any]]
                                for tempGroup in receivedGroups{
                                    if let groupName =  tempGroup["name"] as? String, let groupeID = tempGroup["id"] as? String, let groupDesc = tempGroup["description"] as? String, let groupsCategories = tempGroup["categories"] as? [Int]{
                                        let group = Group(id: groupeID, name: groupName, description: groupDesc, categories: groupsCategories)
                                        groups.append(group)
                                        print(group)
                                        datas(groups, nil)
                                    }
                                }
                            case.failure(let error):
                                print(error)
                                datas(nil, error)
                                
                                
                            }
                            
                            
                    }
                }
            }
            else{
                datas(nil,error)
            }
        }
    }
    
    func getCategoriesFromID(ids:[Int],datas: @escaping ([Category]?,Error?) -> ()){
        var cats = [Category]()
        let flatIDS = ids.flatMap { Optional(String($0)) }
        let joinedIDs = flatIDS.joined(separator: ",")
        let parameters = ["ids":joinedIDs]
        Alamofire.request("\(Constants.baseURL)/achievements/categories", method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result{
                case.success(let value):
                    if let tempCats = value as? [[String:Any]]{
                        for arr in tempCats{
                            
                            if let catID = arr["id"] as? Int,let catName = arr["name"] as? String,let imgURL = arr["icon"] as? String, let tempsAchievement = arr["achievements"] as? [Int],let tempDesc = arr["description"] as? String{
                                let category = Category(id: String(catID), name: catName, icon: imgURL, description: tempDesc, achievements: tempsAchievement)
                                cats.append(category)
                            }
                        }
                        datas(cats, nil)
                        
                    }
                //                    print("VALUEEEES \(value)")
                case.failure(let error):
                    print(error)
                    
                }
        }
    }

    func getAchievementsFromCategories(ids:[Int],data:@escaping ([Achievement]?,Error?) -> ()){
        let flatIDS = ids.flatMap { Optional(String($0)) }
        let joinedIDs = flatIDS.joined(separator: ",")
        let parameters = ["ids":joinedIDs]
        var achievementsToReturn : [Achievement]?
        Alamofire.request("\(Constants.baseURL)/achievements", method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result{
                case.success(let value):
                    print(value)
                    if let val = value as? [[String:Any]]{
                        achievementsToReturn = self.setAchievementCategories(array: val)
                        data(achievementsToReturn, nil)
                    }
                case.failure(let error):
                    print(error)
                    data(nil,error)
                }
                
                
        }
    }
    
    func setAchievementCategories(array:[[String:Any]])->[Achievement]{
        var ach = [Achievement]()
        for element in array{
            if let achievementName = element["name"] as? String, let achievementRequirement = element["requirement"] as? String, let achievementDescription = element["description"] as? String{
                let achievement = Achievement(name: achievementName, description: achievementDescription, requirement: achievementRequirement)
                ach.append(achievement)
            }
            
        }
        
        return ach
    }
    
    func getSingleAchievement(id:String,data:@escaping (Achievement?,Error?) -> ()){
        Alamofire.request("\(Constants.baseURL)/achievements/\(id)", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result{
                case.success(let value):
                    print(value)
                    guard let receivedData = value as? [String:Any] else{
                     print("Nope")
                        break
                    }
                    if let achievementName = receivedData["name"] as? String, let achievementRequirement = receivedData["requirement"] as? String, let achievementDescription = receivedData["description"] as? String{
                        let achievement = Achievement(name: achievementName, description: achievementDescription, requirement: achievementRequirement)
                        data(achievement, nil)
                    }
                case.failure(let error):
                    data(nil,error)
                    print(error)
                    
                }
                
                
        }
        
    }
    
}
