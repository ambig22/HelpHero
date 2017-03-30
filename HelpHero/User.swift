//
//  User.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit

class User {
    let username:String
    var projectLevel:String
    var tttReputation: Double
    
    var image:UIImage?
    
    init(name:String, level:String, reputation:Double)
    {
        username = name
        projectLevel = level
        tttReputation = reputation
    }
    
}
