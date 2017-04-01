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

    let cellId = "cellId"
    
    let sharedManager = DAO.sharedManager
    
    /////////////////////////////////////////////////////////////////
    //
    // UI Elements
    //
    /////////////////////////////////////////////////////////////////
    @IBOutlet weak var questionListTableView: UITableView!
    
    @IBOutlet weak var filterTableView: UITableView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var slideInMenuView: UIView!
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var sliderExitImageView: UIImageView!
    
    @IBOutlet weak var composeContainerView: UIView!
    
    @IBOutlet weak var composeImageView: UIImageView!
    
    //let sharedManager = DAO.sharedManager
    
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
        
        questionListTableView.delegate = self
        questionListTableView.dataSource = self
        
        filterTableView.delegate = self
        filterTableView.dataSource = self
        
        setupViews()
        sliderSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sharedManager.downloadQuestions(completion: {
            self.questionListTableView.reloadData()
        })
        
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false);
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Me", style: .plain, target: self, action: #selector(meButtonPrsd))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func update() {
        self.questionListTableView.reloadData()
        for q in sharedManager.questionsArray {
            print("\(String(describing: q.question)) and \(String(describing: q.isAnswered))")
        }
        print("NSTIMER")
    }

    func setupViews() {
        slideInMenuView.backgroundColor = offGrey
        filterTableView.backgroundColor = offGrey
        
        composeContainerView.layer.cornerRadius = 30
        composeContainerView.backgroundColor = heroColor
        
        composeImageView.image = composeImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        composeImageView.tintColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(launchNewQuestion))
        composeImageView.addGestureRecognizer(tap)
        composeImageView.isUserInteractionEnabled = true
        
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
                print("///////// Profile Page ///////////")
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
        if tableView == self.questionListTableView {
            return sharedManager.questionsArray.count
        } else {
            return projectsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.questionListTableView {
            // need to dequeue later for memory efficiency
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            let activeQuestion = sharedManager.questionsArray[indexPath.row]
            
            cell.textLabel?.font = .systemFont(ofSize: 14)
            cell.textLabel?.text = activeQuestion.question
            cell.detailTextLabel?.text = activeQuestion.currentProject
            cell.detailTextLabel?.textColor = UIColor.lightGray
            cell.imageView?.image = UIImage(named: "question_icon")
            cell.imageView?.image = cell.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            cell.imageView?.tintColor = UIColor.lightGray
            // let insets : UIEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
            // cell.imageView?.image = cell.imageView?.image?.resizableImage(withCapInsets: insets)
            return cell
        } else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            
            cell.textLabel?.font = .systemFont(ofSize: 13)
            cell.textLabel?.text = projectsArray[indexPath.row]
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.questionListTableView {
            return 52
        } else {
            return 36
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntry = EntryController()
        selectedEntry.activeQuestion = sharedManager.questionsArray[indexPath.row]
        self.navigationController?.pushViewController(selectedEntry, animated: true)
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
    
    func launchNewQuestion() {
        let newQuestionVC = NewQuestionController()
        self.present(newQuestionVC, animated: true, completion: nil)
        
    }
    
    func meButtonPrsd() {
        let profileVC = ProfileController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    
    @IBAction func filterButtonPrsd(_ sender: Any)  {
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
