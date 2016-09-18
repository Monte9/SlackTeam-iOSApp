//
//  UserCell.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/15/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit
import AlamofireImage

class UserCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
        //businessNameLabel.preferredMaxLayoutWidth = businessNameLabel.frame.size.width
    }
    
    var user : User! {
        didSet {
            userNameLabel.text = user.realName
            userNameLabel.font = UIFont(name: "Lato-Bold", size: 13)
            
            userTitleLabel.text = user.title
            userTitleLabel.font = UIFont(name: "Lato-Light", size: 11)
            
            if (offlineMode == true) {
                if let imgData = user.imageData {
                    profileImageView.image = UIImage(data: imgData)
                } else if let imgData = user.imageData32 {
                    profileImageView.image = UIImage(data: imgData)
                }
            } else if let profileImage = user.imageOriginalUrl {
                profileImageView.af_setImageWithURL(NSURL(string: profileImage)!)
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
