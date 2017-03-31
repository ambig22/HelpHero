//
//  ProfileController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/31/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {

    /////////////////////////////////////////////////////////////////
    //
    // UI Assets
    //
    /////////////////////////////////////////////////////////////////
    @IBOutlet weak var displayNameLabel: UILabel!
    
    @IBOutlet weak var projectLabel: UILabel!
    
    @IBOutlet weak var repLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var topBackgroundView: UIView!
    
    @IBOutlet weak var profileContainerView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = offGrey
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Me"
        
        setupViews()
        checkIfUserIsLoggedIn()
        
    }

    func setupViews() {
        let color = UIColor.fromRGB(0x7daebc)
        topBackgroundView.backgroundColor = color
        profileContainerView.backgroundColor = color
        
        profileContainerView.layer.cornerRadius = 60
        profileContainerView.layer.masksToBounds = true
        profileContainerView.layer.borderColor = borderGrey.cgColor
        profileContainerView.layer.borderWidth = 1
        
        profileImageView.layer.cornerRadius = 56
        profileImageView.layer.masksToBounds = true
        
        displayNameLabel.textColor = .white
    }
    /////////////////////////////////////////////////////////////////
    //
    // Firebase
    //
    /////////////////////////////////////////////////////////////////
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid != nil { 
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.displayNameLabel.text = dictionary["displayName"] as? String
                    self.projectLabel.text = dictionary["currentProject"] as? String
                    self.emailLabel.text = dictionary["email"] as? String
                    self.repLabel.text = dictionary["reputation"] as? String
                    if self.repLabel.text == nil {
                        self.repLabel.text = "0"
                    }
                }
                
            }, withCancel: nil)
        }
    }

}
