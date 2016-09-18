//
//  User.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/16/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var imageOriginalUrl: String? = nil
    dynamic var image32Url: String? = nil
    dynamic var firstName: String? = nil
    dynamic var lastName: String? = nil
    dynamic var realName: String? = nil
    dynamic var title: String? = nil
    dynamic var skype: String? = nil
    dynamic var phone: String? = nil
    dynamic var userName: String? = nil
    dynamic var email: String? = nil
    dynamic var timezone: String? = nil
    dynamic var imageData: NSData? = nil
    dynamic var imageData32: NSData? = nil
    
}
