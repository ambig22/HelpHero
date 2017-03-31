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
    
    @IBOutlet weak var questionsListCollection: UICollectionView!
    
    let shardedManager = DAO.sharedManager
    
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            handleLogout()
        }

        self.navigationController?.navigationBar.barTintColor = heroColor
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = false
        
        shardedManager.downloadQuestions()
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

    /////////////////////////////////////////////////////////////////
    //
    // tableView
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
    }
    
    @IBAction func logoutButtonPrsd(_ sender: Any) {
        handleLogout()
    }
}
