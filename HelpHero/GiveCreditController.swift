//
//  GiveCreditController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/31/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase


class GiveCreditController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    
    var users = [User]()
    
    /////////////////////////////////////////////////////////////////
    //
    // UI Assets
    //
    /////////////////////////////////////////////////////////////////
    @IBOutlet weak var lightbulbImageView: UIImageView!
    
    @IBOutlet weak var solvedLabel: UILabel!
    
    @IBOutlet weak var userListTableView: UITableView!

    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = offGrey
        userListTableView.delegate = self
        userListTableView.dataSource = self
        
        setupViews()
        fetchUser()
    }

    func setupViews() {
        lightbulbImageView.image = lightbulbImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        lightbulbImageView.tintColor = UIColor.fromRGB(0xffbc1b)
        
        solvedLabel.textColor = heroColor
    
    }
    
    /////////////////////////////////////////////////////////////////
    //
    // tableView DataSource & Delegate
    //
    /////////////////////////////////////////////////////////////////
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // need to dequeue later for memory efficiency
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = "Dummy Title"
        
        return cell
    }
    
    
    /////////////////////////////////////////////////////////////////
    //
    // Firebase
    //
    /////////////////////////////////////////////////////////////////
    func fetchUser() {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            print("/////////////////// Fetch Users - User Found ///////////////////")
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.setValuesForKeys(dictionary)
                print(user.displayName!)
                
            }
            
        }, withCancel: nil)
    }
    
    
    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////
    
}