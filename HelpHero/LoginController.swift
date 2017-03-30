//
//  ViewController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase

// Settings
let windowWidth = UIScreen.main.bounds.width
let windowHeight = UIScreen.main.bounds.height

let heroColor = UIColor.fromRGB(0x487b8e)
let offGrey = UIColor.fromRGB(0xf4f4f4)
let ashGrey = UIColor.fromRGB(0x555555)

let transparent = UIColor.black.withAlphaComponent(0)
let halfTransparent = UIColor.black.withAlphaComponent(0.5)
let mostlyTransparent = UIColor.black.withAlphaComponent(0.3)

class CustomTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .white
        self.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        self.textColor = ashGrey
        self.layer.cornerRadius = 5
    }
}

class LoginController: UIViewController {
    

    /////////////////////////////////////////////////////////////////
    //
    // UI Assets
    //
    /////////////////////////////////////////////////////////////////

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        view.backgroundColor = offGrey
        
    }
    
    func setupViews() {
        registerButton.backgroundColor = heroColor
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        
        logoImageView.image = logoImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        logoImageView.tintColor = ashGrey
        logoImageView.layer.shadowColor = UIColor.black.cgColor
        logoImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        logoImageView.layer.shadowOpacity = 0.1
        logoImageView.layer.shadowRadius = 1.0
    }

    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////
    @IBAction func loginRegisterButtonPrsd(_ sender: Any) {
        print("handle register")
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = usernameTextField.text else {
            print("form not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                print("UID Error")
                return
            }
            // successfully authenticated user
            let ref = FIRDatabase.database().reference(fromURL: "https://helphero-7b63c.firebaseio.com/")
            let usersRef = ref.child("users").child(uid)
            let values = ["displayName": name, "email": email]
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                
                print("Saved User Successfully into FIR DB")
                
                let homeVC = HomeController()
                self.present(homeVC, animated: true, completion: nil)
            })
            
        })
    
    }

    
}

