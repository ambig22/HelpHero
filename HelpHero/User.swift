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
    var email:String
    var password:String
    var projectLevel:String
    var reputation: Double
    
    var image:UIImage?
    
    init(name:String, level:String, email:String, password:String,reputation:Double)
    {
        username = name
        self.email = email
        projectLevel = level
        self.reputation = reputation
        self.password = password
    }
    
}
