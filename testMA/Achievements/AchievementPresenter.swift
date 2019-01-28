//
//  AchievementPresenter.swift
//  testMA
//
//  Created by Adadémey Marvin on 26/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD

class AchievementPresenter{
    var controller : AchievementViewController?
    
    /// Method to bind the controller & the presenter
    ///
    /// - Parameter controllerToAttach: The controller to attach
    func attachController(controllerToAttach:AchievementViewController){
        self.controller = controllerToAttach
    }
    
    /// Method to return the title of the controller
    ///
    /// - Returns: The title
    func getTitle()->String{
        return "Achievements"
    }
    
    /// An alert to show details of the achievement. I choose this wat to present the datas because in my opinion, it's not worthy to create a detailled view juste to show 2 sentences.
    ///
    /// - Parameters:
    ///   - successName: Name of the achievement
    ///   - succesDecription: Description of the achievement
    ///   - succesRequirement: Requirement of the achievement
    func alertWithSucces(successName:String,succesDecription:String,succesRequirement:String){
        let alert = UIAlertController(title: successName, message: "Description : \(succesDecription)\n\nRequirements: \(succesRequirement)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action) in
            let text = "This is the text....."
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.controller?.view
            self.controller?.present(activityViewController, animated: true, completion: nil)
        }))
        controller?.present(alert, animated: true, completion: nil)
    }
    
    /// To get the achievement from categories
    ///
    /// - Parameters:
    ///   - ids: Categories ids
    ///   - datas: Achievement formatted in "Achievement" object
    func getAchievementCategories(ids:[Int],datas:@escaping ([Achievement]?,Error?) -> ()){
        Manager.instance.getAchievementsFromCategories(ids: ids) { (ach, error) in
            if error == nil{
                datas(ach, nil)
            }
            else{
                datas(nil,error)
            }
        }
        
    }
    
    func showHUD(){
        ProgressHUD.show("Loading...")
        
    }
    
    func hideHUD(){
        ProgressHUD.dismiss()
    }
    
    func errorHUD(){
        ProgressHUD.showError()
    }
    
    
}
