//
//  ViewController.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/15/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit
import Alamofire

let token = "xoxp-4698769766-4698769768-18910479235-8fa82d53b2"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    //vars
    var users: [User]? = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        //make API call and fetch user data
        makeAPICall()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //Customize the navigation bar title and color
        let navigationBar = self.navigationController?.navigationBar
        
        //make navigation bar transparent
        navigationBar!.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar!.translucent = true

        //set navigation bar title with color
        navigationItem.title = "Team Name"
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
                    self.users = User.users((json["members"] as? [NSDictionary])!)
                    self.tableView.reloadData()
                }
                else {
                    print("ERROR: \(json["error"] as! String)")
                }
            }
        }
    }

}

