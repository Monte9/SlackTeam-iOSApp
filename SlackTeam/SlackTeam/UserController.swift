//
//  UserController.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/15/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit

class UserController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 50)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Customize the navigation bar title and color
        let navigationBar = self.navigationController?.navigationBar
        
        //make navigation bar transparent
        navigationBar!.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar!.shadowImage = UIImage()
        navigationBar!.translucent = true
        
        //set navigation bar title with color
//        navigationItem.title = "User Name"
//        navigationBar!.titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 42/255, green: 46/255, blue: 49/255, alpha: 1), NSFontAttributeName: UIFont(name: "Lato-Black", size: 17)!]
    }
    
}
