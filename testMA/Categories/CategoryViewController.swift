//
//  CategoryViewController.swift
//  testMA
//
//  Created by Adadémey Marvin on 25/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit
import AlamofireImage
import Hero

class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
//    let tableView = UITableView()
    @IBOutlet weak var tableView: UITableView!
    var caregoriesID : [Int]?
    var categoryID : String?
    var presenter = CategoryPresenter()
    var categories = [Category]()
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
        presenter.showHUD()
        presenter.attachController(controllerToAttach:self)
        if let tempCategory = caregoriesID{
            presenter.getCatFromIDs(ids: tempCategory, datas: { (receivedCategories, error) in
                if error == nil{
                    self.categories = receivedCategories!
                    self.tableView.reloadData()
                    self.presenter.hideHUD()
                }
                else{
                    self.presenter.errorHUD()
                }
            })
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    func setUI(){
        self.hero.isEnabled = true
        self.view.addSubview(tableView)
        self.title = presenter.getTitle()
    }
    
    func setTableView(){
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //MARK: - Table View delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToAchievements(ids: categories[indexPath.row].achievements)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = categories[indexPath.row].name
        if categories[indexPath.row].description != ""{
            count += 1
        }
        cell.detailTextLabel?.text = categories[indexPath.row].description
        let filter = AspectScaledToFillSizeFilter(size: CGSize(width: 64, height: 64))
        cell.imageView?.af_setImage(withURL: URL(string:categories[indexPath.row].icon)!,placeholderImage: UIImage(named: "Placeholder"),filter:filter)
        cell.imageView?.hero.id = categories[indexPath.row].name
        return cell
    }
  
}
