//
//  User.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase

class User {
    let displayName:String
    var email:String
    var currentProject:String
    var reputation: Double
    
    var image:UIImage?
    
    var sharedManager = DAO.sharedManager
    
    init(name:String, level:String, email:String, reputation:Double)
    {
        displayName = name
        self.email = email
        currentProject = level
        self.reputation = reputation
    }
    
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value as? NSDictionary
        
        self.displayName = value?["displayName"] as! String
        self.currentProject = value?["currentProject"] as! String
        self.email = value?["email"] as! String
        self.reputation = value?["reputation"] as! Double
        
        let loadUsers = User(name: displayName, level: currentProject, email: email, reputation: reputation)
        
        sharedManager.usersArray.append(loadUsers)
        print("Num of users \(sharedManager.usersArray.count)")
    }
}
