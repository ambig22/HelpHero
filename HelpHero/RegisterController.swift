//
//  RegisterController.swift
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

class RegisterController: UIViewController {
    
    /////////////////////////////////////////////////////////////////
    //
    // UI Assets
    //
    /////////////////////////////////////////////////////////////////

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var displayNameTextField: CustomTextField!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        view.backgroundColor = offGrey
        
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        logoImageView.image = logoImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        logoImageView.tintColor = heroColor
        
        registerButton.backgroundColor = heroColor
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.layer.cornerRadius = 5
    }

    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////

    @IBAction func registerBtn(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = displayNameTextField.text else {
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
            let values = ["displayName": name, "email": email, "currentProject": "N/A", "Reputation":0] as [String : Any]
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                
                print("Saved User Successfully into FIR DB")
                self.dismiss(animated: true, completion: nil)
            })
            
        })
    }
    
}
