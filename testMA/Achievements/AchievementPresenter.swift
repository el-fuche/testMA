//
//  AchievementPresenter.swift
//  testMA
//
//  Created by Adadémey Marvin on 26/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import UIKit

class AchievementPresenter{
    var controller : AchievementViewController?
    
    func attachController(controllerToAttach:AchievementViewController){
        self.controller = controllerToAttach
    }
    
    func getTitle()->String{
        return "Categories"
    }
    
    func alertWithSucces(successName:String,succesDecription:String,succesRequirement:String)->UIAlertController{
        let alert = UIAlertController(title: successName, message: "Description : \(succesDecription)\n\nRequirements: \(succesRequirement)", preferredStyle: .alert)
        
        return alert
//        controller?.present(alert, animated: true, completion: nil)
        
    }
    
    func getAchievementCategories(ids:[Int],datas:@escaping ([Achievement]?,Error?) -> ()){
//        Manager.instance.getCategories(ids: ids)
        Manager.instance.getAchievementsFromCategories(ids: ids) { (ach, error) in
            if error == nil{
                datas(ach, nil)
            }
            else{
                datas(nil,error)
            }
        }
        
    }
    
    
}
