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
    
    func getCatFromIDs(ids:[Int],id:String,datas:@escaping ([Category]?,Error?) -> ()){

        Manager.instance.getCategoriesFromID(ids: ids) { (cats, error) in
            if error == nil{
                datas(cats,nil)
            }
            else{
                datas(nil,error)
            }
        }
    }
    
    func goToAchievements(ids:[Int]){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "achievementVC") as? AchievementViewController{
            nextViewController.ids = ids
            controller?.navigationController?.pushViewController(nextViewController, animated: true)
            
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
