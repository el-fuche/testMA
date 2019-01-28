//
//  GroupsPresenter.swift
//  testMA
//
//  Created by Adadémey Marvin on 25/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import UIKit
import ProgressHUD

class GroupsPresenter{
    var groups = [Group]()
    var controller : GroupsViewController?
    
    /// To bind the controller & the presenter
    ///
    /// - Parameter controllerToAttach: The controller to
    func attachController(controllerToAttach:GroupsViewController){
        self.controller = controllerToAttach
    }
    
    func getTitle()->String{
        return "Groups"
    }
    
    /// Methods to get groups
    ///
    /// - Parameter groupsArray: 
    func getGroups(groupsArray:@escaping ([Group]?,Error?) -> ()){
        Manager.instance.getGroups { (groups, error) in
            if error == nil{
                self.groups = groups!
                groupsArray(self.groups,nil)
                
            }
            else{
                groupsArray(nil,error)
            }
        }
    }
        
    /// Go to the next controller
    ///
    /// - Parameters:
    ///   - ids: Categories to swow in the next controller
    func goToCategoriesFromGroups(ids:[Int],id:String){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "categoriesVC") as? CategoryViewController{
                nextViewController.caregoriesID = ids
                nextViewController.categoryID = id
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
