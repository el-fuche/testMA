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
    //MARK: - Groups methods
    
    
    /// Get all existing groups IDs
    ///
    /// - Parameter datas: return of the request
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
    
    /// To get all groups details
    ///
    /// - Parameter datas: return of the request
    func getGroups(datas: @escaping ([Group]?,Error?) -> ()){
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
                                let receivedGroups = self.setGroups(datas:  value as! [[String:Any]])
                                datas(receivedGroups, nil)
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
    
    /// To format the request array in Group array
    ///
    /// - Parameter datas: Datas from original request
    /// - Returns: result in "Group" object array
    private func setGroups(datas:[[String:Any]])->[Group]?{
        var groups = [Group]()
        
        for tempGroup in datas{
            if let groupName =  tempGroup["name"] as? String, let groupeID = tempGroup["id"] as? String, let groupDesc = tempGroup["description"] as? String, let groupsCategories = tempGroup["categories"] as? [Int]{
                let group = Group(id: groupeID, name: groupName, description: groupDesc, categories: groupsCategories)
                groups.append(group)
            }
        }
        return groups
    }
    
    //MARK: - Categories methods

    /// Get suuces categories from ID
    ///
    /// - Parameters:
    ///   - ids: ids of the achiements categories
    ///   - datas: Return of the request, formatted in "Category" objects
    func getCategoriesFromID(ids:[Int],datas: @escaping ([Category]?,Error?) -> ()){
        let flatIDS = ids.flatMap { Optional(String($0)) }
        let joinedIDs = flatIDS.joined(separator: ",")
        let parameters = ["ids":joinedIDs]
        Alamofire.request("\(Constants.baseURL)/achievements/categories", method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result{
                case.success(let value):
                    if let tempCats = value as? [[String:Any]]{
                        
                        datas(self.setCategories(datas: tempCats), nil)
                    }
                case.failure(let error):
                    print(error)
                }
        }
    }
    
   /// To set categories
   ///
   /// - Parameter datas: the datas to format
   /// - Returns: formatted data, returns "Category" array
   private func setCategories(datas:[[String:Any]])->[Category]?{
        var cats = [Category]()
        for arr in datas{
            if let catID = arr["id"] as? Int,let catName = arr["name"] as? String,let imgURL = arr["icon"] as? String, let tempsAchievement = arr["achievements"] as? [Int],let tempDesc = arr["description"] as? String{
                let category = Category(id: String(catID), name: catName, icon: imgURL, description: tempDesc, achievements: tempsAchievement)
                cats.append(category)
            }
        }
        return cats
    }
    
    //MARK: - Achievements methods

    /// Get achievement from ids
    ///
    /// - Parameters:
    ///   - ids: ids to search
    ///   - data: return, formatted in "Achievement" objects
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
    
    /// To format request datas in "Achievement" objects
    ///
    /// - Parameter array: raw array from request
    /// - Returns: datss formatted in "Achievement" objects
    private func setAchievementCategories(array:[[String:Any]])->[Achievement]{
        var ach = [Achievement]()
        for element in array{
            if let achievementName = element["name"] as? String, let achievementRequirement = element["requirement"] as? String, let achievementDescription = element["description"] as? String{
                let achievement = Achievement(name: achievementName, description: achievementDescription, requirement: achievementRequirement)
                ach.append(achievement)
            }
        }
        return ach
    }
    
}
