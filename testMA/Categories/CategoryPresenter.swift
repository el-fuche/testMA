//
//  CategoryPresenter.swift
//  testMA
//
//  Created by Adadémey Marvin on 25/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit
import ProgressHUD

class CategoryPresenter {
    var groups = [Category]()
    var controller : CategoryViewController?
    
    func attachController(controllerToAttach:CategoryViewController){
        self.controller = controllerToAttach
    }
    
    func getTitle()->String{
        return "Categories"
    }
    
    /// Get categories
    ///
    /// - Parameters:
    ///   - ids: categories ids
    ///   - datas: Categories array
    func getCatFromIDs(ids:[Int],datas:@escaping ([Category]?,Error?) -> ()){
        Manager.instance.getCategoriesFromID(ids: ids) { (cats, error) in
            if error == nil{
                datas(cats,nil)
            }
            else{
                datas(nil,error)
            }
        }
    }
    
    /// Go to achievements
    ///
    /// - Parameter ids: achievements ids
    func goToAchievements(ids:[Int]){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "achievementVC") as? AchievementViewController{
            nextViewController.ids = ids
            controller?.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
    }
    
    //MARK: - HUD methods
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
