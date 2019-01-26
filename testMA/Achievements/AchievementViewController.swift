//
//  AchievementViewController.swift
//  testMA
//
//  Created by Adadémey Marvin on 26/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    //    let tableView = UITableView()
    var ids : [Int]?
    var presenter = AchievementPresenter()
    var achievements = [Achievement]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
        presenter.getAchievementCategories(ids: ids!) { (tempAchievements, error) in
            if error == nil{
                self.achievements = tempAchievements!
                self.tableView.reloadData()
            }
            else{
                print(error.debugDescription)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI(){
        self.view.addSubview(tableView)
        
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.view.frame
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = achievements[indexPath.row].name
        cell.detailTextLabel?.text = achievements[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = presenter.alertWithSucces(successName: achievements[indexPath.row].name, succesDecription: achievements[indexPath.row].description, succesRequirement: achievements[indexPath.row].requirement)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action) in
            let text = "This is the text....."
            let textShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        //        let alert = UIAlertController(title: "successName", message: "test", preferredStyle: .alert)
        //        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: nil))
        //        self.present(alert, animated: true, completion: nil)
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
