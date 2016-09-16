//
//  User.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/15/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var imageOriginalUrl: NSURL?
    var image32Url: NSURL?
    var firstName: String?
    var lastName: String?
    var realName: String?
    var title: String?
    var skype: String?
    var phone: String?
    var userName: String?
    
    init(dictionary: NSDictionary) {
        
        self.userName = dictionary["name"] as? String
        
        if let profile = dictionary["profile"] as? NSDictionary {
            if let imageOriginalString = profile["image_original"] as? String {
                imageOriginalUrl = NSURL(string: imageOriginalString)!
            } else {
                imageOriginalUrl = nil
            }
            
            if let image32String = profile["image_32"] as? String {
                image32Url = NSURL(string: image32String)!
            } else {
                image32Url = nil
            }
            
            self.firstName = profile["first_name"] as? String
            self.lastName = profile["last_name"] as? String
            self.realName = profile["real_name"] as? String
            self.title = profile["title"] as? String
            self.skype = profile["skype"] as? String
            self.phone = profile["phone"] as? String
        }
    }
    
    class func users(array: [NSDictionary]) -> [User] {
        var users = [User]()
        for dictionary in array {
            let user = User(dictionary: dictionary)
            users.append(user)
        }
        return users
    }

}
