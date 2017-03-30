//
//  HomeController.swift
//  
//
//  Created by Jerry Chen on 3/30/17.
//
//

import UIKit
import Firebase

class HomeController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            handleLogout()
        }

    }

    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////
    
    @IBAction func logoutButtonPrsd(_ sender: Any) {
        handleLogout()
    }
}
