//
//  HomeController.swift
//  
//
//  Created by Jerry Chen on 3/30/17.
//
//

import UIKit
import Firebase

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /////////////////////////////////////////////////////////////////
    //
    // UI Elements
    //
    /////////////////////////////////////////////////////////////////
    @IBOutlet weak var questionListTableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var slideInMenuView: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var sliderExitImageView: UIImageView!
    
    @IBOutlet weak var composeContainerView: UIView!
    
    let shardedManager = DAO.sharedManager
    
    @IBOutlet weak var composeImageView: UIImageView!
    
    let sliderWidth = 260
    
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()

        self.navigationController?.navigationBar.barTintColor = heroColor
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = false
        
        setupViews()
        sliderSetup()
        shardedManager.downloadQuestions()
    }

    func setupViews() {
        composeContainerView.layer.cornerRadius = 30
        composeContainerView.backgroundColor = heroColor
        
        composeImageView.image = composeImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        composeImageView.tintColor = .white
        
        shadowView.backgroundColor = halfTransparent
    }
    
    func sliderSetup() {
        slideInMenuView.alpha = 0
        shadowView.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSlider))
        sliderExitImageView.addGestureRecognizer(tap)
        sliderExitImageView.isUserInteractionEnabled = true
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let registerController = RegisterController()
        present(registerController, animated: true, completion: nil)
    }

    func dismissSlider() {
        UIView.animate(withDuration: 0.4, animations: {
            self.shadowView.alpha = 0
            self.slideInMenuView.alpha = 0
        })
    }
    /////////////////////////////////////////////////////////////////
    //
    // Firebase
    //
    /////////////////////////////////////////////////////////////////
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            handleLogout()
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                }
                print("////////////////////")
                print(snapshot)
            }, withCancel: nil)
        }
    }
    
    /////////////////////////////////////////////////////////////////
    //
    // tableView Delegate & DataSource
    //
    /////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////
    @IBAction func testEntryButtonPrsd(_ sender: Any) {
        let entryVC = EntryController()
        self.navigationController?.pushViewController(entryVC, animated: true)
    }
    
    @IBAction func newQuestionButtonPrsd(_ sender: Any) {
        let newQuestionVC = NewQuestionController()
        self.present(newQuestionVC, animated: true, completion: nil)
        
    }
    
    @IBAction func filterButtonPrsd(_ sender: Any) {
        // Transition spring damping animation
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.shadowView.alpha = 1
            self.slideInMenuView.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func logoutButtonPrsd(_ sender: Any) {
        handleLogout()
    }
    
}
