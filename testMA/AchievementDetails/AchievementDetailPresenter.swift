//
//  AchievementPresenter.swift
//  testMA
//
//  Created by Adadémey Marvin on 26/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import UIKit
class AchievementDetailPresenter {
    var controller : AchievementDetailViewController?

    
    func attachController(controllerToAttach:AchievementDetailViewController){
        self.controller = controllerToAttach
    }
    
    func getAchievement(id:String,data:@escaping (Achievement?) -> ()){
        Manager.instance.getSingleAchievement(id: id) { (datas, error) in
            if error == nil{
                data(datas)
            }
            else{
                let alert = UIAlertController(title: "Erreur", message: error.debugDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
                self.controller?.present(alert, animated: true, completion: nil)
            }
        }
//        Manager.instance.getSingleAchiement(id: id)
    }
    

}
