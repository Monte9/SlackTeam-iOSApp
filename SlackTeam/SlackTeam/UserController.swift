//
//  UserController.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/15/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit

class UserController: UIViewController {

    //outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 50)

        fullNameLabel.text = user?.realName
        fullNameLabel.font = UIFont(name: "Lato-Bold", size: 18)
        
        usernameLabel.text = "@\(user!.userName!)"
        usernameLabel.font = UIFont(name: "Lato-Regular", size: 15)
        
        if let profileImage = user?.imageOriginalUrl {
            profileImageView.af_setImageWithURL(profileImage)
        }
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
        
        messageButton.backgroundColor = UIColor.clearColor()
        messageButton.layer.cornerRadius = 5
        messageButton.layer.borderWidth = 1
        messageButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        messageButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 17)
        
        callButton.backgroundColor = UIColor.clearColor()
        callButton.layer.cornerRadius = 5
        callButton.layer.borderWidth = 1
        callButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        callButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 17)
        
        moreInfoButton.backgroundColor = UIColor.clearColor()
        moreInfoButton.layer.cornerRadius = 5
        moreInfoButton.layer.borderWidth = 1
        moreInfoButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        moreInfoButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: 17)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = profileImageView.frame
        gradient.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        profileImageView.layer.insertSublayer(gradient, atIndex: 0)
    }
    
}
