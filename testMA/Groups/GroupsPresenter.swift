//
//  GroupsPresenter.swift
//  testMA
//
//  Created by Adadémey Marvin on 25/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import Foundation
import UIKit

class GroupsPresenter{
    var groups = [Group]()
    var controller : GroupsViewController?
    
    func attachController(controllerToAttach:GroupsViewController){
        self.controller = controllerToAttach
    }
    
    func getTitle()->String{
        return "Groups"
    }
    
    func getGroups(groupsArray:@escaping ([Group]?) -> ()){
        Manager.instance.getGroups { (groups, error) in
            if error == nil{
                self.groups = groups!
                groupsArray(self.groups)
                
            }
        }
    }
        
    func goToCategoriesFromGroups(ids:[Int],id:String){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "categoriesVC") as? CategoryViewController{
                nextViewController.caregoriesID = ids
                nextViewController.categoryID = id
                controller?.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
//        Manager.instance.getAllGroups { (groups, error) in
//            print(groups!)
//        }
        

        
    
    
}