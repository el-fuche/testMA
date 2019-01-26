//
//  AchievementViewController.swift
//  testMA
//
//  Created by Adadémey Marvin on 26/01/2019.
//  Copyright © 2019 Adadémey Marvin. All rights reserved.
//

import UIKit
import LoadingPlaceholderView
import Windless

class AchievementDetailViewController: UIViewController {
    @IBOutlet weak var requirementText: UILabel!
    @IBOutlet weak var requirementTitle: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var achievementImageView: UIImageView!
    let presenter = AchievementDetailPresenter()
    var imgContainer : UIImage?
    var heroID : String?
    var achievementID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachController(controllerToAttach: self)
        self.hero.isEnabled = true
        achievementImageView.hero.id = heroID
//        achievementImageView.image = imgContainer
        let loadingPlaceholderView = LoadingPlaceholderView()
//        descriptionText.windless.start()
        self.view.windless.setupWindlessableViews([descriptionText, requirementText]).start()
//        loadingPlaceholderView.cover(requirementText)
        loadingPlaceholderView.cover(achievementImageView, animated: true)


//        presenter.getAchievement(id: achievementID!) { (achievement) in
//            self.descriptionText.text = achievement?.description
//            self.requirementText.text = achievement?.requirement
//            self.view.windless.end()
//
//        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        presenter.getAchievement(id: achievementID!) { (achievement) in
//            self.descriptionText.text = achievement?.description
//            self.requirementText.text = achievement?.requirement
//            self.view.windless.end()
//            self.achievementImageView.isHidden = false
//
//        }
    }
    
    override func viewDidLayoutSubviews() {
        presenter.getAchievement(id: achievementID!) { (achievement) in
            self.descriptionText.text = achievement?.description
            self.requirementText.text = achievement?.requirement
            self.achievementImageView.image = self.imgContainer

            self.view.windless.end()
//            self.achievementImageView.isHidden = true
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeModal(_ sender: Any) {
        self.hero.dismissViewController()

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
