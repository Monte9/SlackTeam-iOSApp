//
//  UserController.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/15/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit
import AudioToolbox

class UserController: UIViewController {

    //outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var user: User?
    var aboutUser: [String:String]? = ["title":"What I do", "skype":"Skype", "phone":"Phone", "email":"Email", "timezone": "Timezone"]
    
    static var height = 310
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //Customize the navigation bar title and color
        let navigationBar = self.navigationController?.navigationBar
        
        //make navigation bar transparent
        navigationBar!.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar!.shadowImage = UIImage()
        navigationBar!.translucent = true
        
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
        gradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 253)
        gradient.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 2)
        profileImageView.layer.insertSublayer(gradient, atIndex: 0)
        
        UserController.height = 310
    }
    
    func setupView() {
        setupHeaderInfo()
        
        setupBodyInfo()
    }
    
    func setupHeaderInfo() {
        fullNameLabel.text = user?.realName
        fullNameLabel.font = UIFont(name: "Lato-Bold", size: 18)
        
        usernameLabel.text = "@\(user!.userName!)"
        usernameLabel.font = UIFont(name: "Lato-Regular", size: 15)
        
        if (offlineMode == true) {
            if let imgData = user!.imageData {
                profileImageView.image = UIImage(data: imgData)
            } else if let imgData = user!.imageData32 {
                profileImageView.image = UIImage(data: imgData)
            }
        } else if let profileImage = user?.imageOriginalUrl {
            profileImageView.af_setImageWithURL(NSURL(string: profileImage)!)
        }
    }
    
    func setupBodyInfo() {
        
        if let title = (user?.title) {
            displayUserDetailView("title", value: title)
            displayLine()
        }
        
        if let timezone = (user?.timezone) {
            displayUserDetailView("timezone", value: timezone)
            displayLine()
        }
        
        if let phone = (user?.phone) {
            displayUserDetailView("phone", value: phone)
            displayLine()
        }
        
        if let email = (user?.email) {
            displayUserDetailView("email", value: email)
            displayLine()
        }
        
        if let skype = (user?.skype) {
            displayUserDetailView("skype", value: skype)
        }
        
    }
    
    func displayUserDetailView(detail: String, value: String) {
        if let viewOne = NSBundle.mainBundle().loadNibNamed("UserDetailView", owner: self, options: nil).first as? UserDetailView {
            viewOne.frame.origin.x = 15
            viewOne.frame.origin.y = CGFloat(UserController.height)
            //viewOne.center = CGPointMake(view.bounds.width/2, CGFloat(UserController.height))
            
            viewOne.detailDescriptionLabel.text = aboutUser![detail]
            viewOne.detailDescriptionLabel.font = UIFont(name: "Lato-Light", size: 14)
            
            viewOne.detailAboutLabel.text = value
            viewOne.detailAboutLabel.font = UIFont(name: "Lato-Regular", size: 16)
            
            scrollView.addSubview(viewOne)
        }
    }
    
    func displayLine() {
        UserController.height += 65
        
        let lineView = UIView(frame: CGRectMake(15,CGFloat(UserController.height),view.bounds.width,1.0))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 211/255).CGColor
        scrollView.addSubview(lineView)
        
        UserController.height += 5
    }
    
    @IBAction func messageUserPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Coming soon!", message:
            "Message feature currently unavailable!", preferredStyle: UIAlertControllerStyle.Alert)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // vibration
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func callUserPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Coming soon!", message:
            "Call feature currently unavailable!", preferredStyle: UIAlertControllerStyle.Alert)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // vibration
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func moreInfoButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "More Information", message: "", preferredStyle: .ActionSheet)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)) // vibration
        
        let firstAction = UIAlertAction(title: "Join date", style: .Default) { (alert: UIAlertAction!) -> Void in
            print("View Join Date: coming soon!")
        }
        let secondAction = UIAlertAction(title: "Last online", style: .Default) { (alert: UIAlertAction!) -> Void in
            print("View last online: coming soon!")
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        presentViewController(alert, animated: true, completion:nil)
    }
    
}
