//
//  ViewController.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/15/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import RealmSwift
import Realm

let token = "xoxp-4698769766-4698769768-18910479235-8fa82d53b2"
var offlineMode = false

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var testImageView: UIImageView!
    
    //vars
    var users: [User]? = []
    
    // instance of Realm object
    let realmObject = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Display HUD right before API request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        //Realm db path: DEBUG
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        let dbUsers = realmObject.objects(User.self)
        
        if dbUsers.count > 0 {
            print("Found users in DB")
            var newUsersArray = [User]()
            for user in dbUsers {
                newUsersArray.append(user)
            }
            users = newUsersArray
            
            // Hide HUD once network request comes back (must be done on main UI thread)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            //set offline mode to true to load image from NSData
            offlineMode = true
        } else {
            //make API call and save data in the realm db
            makeAPICall()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //Customize the navigation bar title and color
        let navigationBar = self.navigationController?.navigationBar
        
        //make navigation bar transparent
        navigationBar!.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar!.shadowImage = nil
        navigationBar!.translucent = false

        //set navigation bar title with color
        navigationItem.title = "iOS Exercise"
        navigationBar!.titleTextAttributes = [NSForegroundColorAttributeName : UIColor(red: 42/255, green: 46/255, blue: 49/255, alpha: 1), NSFontAttributeName: UIFont(name: "Lato-Black", size: 17)!]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "UserCell", forIndexPath: indexPath) as! UserCell

        cell.user = users![indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func makeAPICall() {
        Alamofire.request(.GET, "https://slack.com/api/users.list?token=\(token)").responseJSON { response in
            if let json = response.result.value {
                if (json["ok"] as! Bool) {
                    print("Connection to API successful!")
                    
                    self.users = self.saveUsers((json["members"] as? [NSDictionary])!)
                    self.tableView.reloadData()
                    
                    // Hide HUD once network request comes back (must be done on main UI thread)
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                }
                else {
                    print("ERROR: \(json["error"] as! String)")
                }
            } else {
                // Hide HUD once network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                let alertController = UIAlertController(title: "Error!", message:
                    "Network request failed. Check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
                //set offline mode to true to load image from NSData
                offlineMode = true
            }
        }
    }
    
    func saveUsers(array: [NSDictionary]) -> [User] {
        var users = [User]()
        for dictionary in array {
            let user = newUser(dictionary)
            
            if let profileImage = user.imageOriginalUrl {
                if let url = NSURL(string: profileImage) {
                    if let imgData = NSData(contentsOfURL: url) {
                        user.imageData = imgData
                    }
                }
            }
            if let profileImage32 = user.image32Url {
                if let url = NSURL(string: profileImage32) {
                    if let imgData = NSData(contentsOfURL: url) {
                        user.imageData32 = imgData
                    }
                }
            }
            
            //write the settings object to db for persistence
            try! realmObject.write() {
                realmObject.add(user)
                print("New User saved with name: \(user.realName)")
                users.append(user)
            }
        }
        return users
    }
    
    func newUser(dictionary: NSDictionary) -> User {
        
        let user = User()
        
        user.userName = dictionary["name"] as? String
        user.timezone = dictionary["tz_label"] as? String
        
        if let profile = dictionary["profile"] as? NSDictionary {
            if let imageOriginalString = profile["image_original"] as? String {
                user.imageOriginalUrl = imageOriginalString
            } else {
                user.imageOriginalUrl = nil
            }
            
            if let image32String = profile["image_32"] as? String {
                user.image32Url = image32String
            } else {
                user.image32Url = nil
            }
            
            user.firstName = profile["first_name"] as? String
            user.lastName = profile["last_name"] as? String
            user.realName = profile["real_name"] as? String
            user.title = profile["title"] as? String
            user.skype = profile["skype"] as? String
            user.phone = profile["phone"] as? String
            user.email = profile["email"] as? String
        }
        
        return user
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let user = users![indexPath!.row]
        
        let userController = segue.destinationViewController as! UserController
        
        userController.user = user
    }

}

