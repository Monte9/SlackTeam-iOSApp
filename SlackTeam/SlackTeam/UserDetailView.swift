//
//  UserDetailView.swift
//  SlackTeam
//
//  Created by Monte with Pillow on 9/16/16.
//  Copyright © 2016 Monte Thakkar. All rights reserved.
//

import UIKit

class UserDetailView: UIView {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailAboutLabel: UILabel!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
