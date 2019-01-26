//
//  GroupsViewController.swift
//  testMA
//
//  Created by Adadémey Marvin on 25/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
//    let tableView = UITableView()
    let presenter = GroupsPresenter()
    var groups = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
        presenter.attachController(controllerToAttach: self)
        presenter.getGroups { (tempGroup) in
            self.groups = tempGroup!
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        self.view.addSubview(tableView)
        self.title = presenter.getTitle()
    }
    
    func setTableView(){
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = groups[indexPath.row].name
        cell.detailTextLabel?.text = groups[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToCategoriesFromGroups(ids: groups[indexPath.row].categories, id:groups[indexPath.row].id)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
