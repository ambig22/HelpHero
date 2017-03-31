//
//  NewQuestionController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase

class NewQuestionController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {

    /////////////////////////////////////////////////////////////////
    //
    // UI Assets
    //
    /////////////////////////////////////////////////////////////////
    @IBOutlet weak var projectButton: UIButton!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var jesseContainerView: UIView!
    
    @IBOutlet weak var jesseImageView: UIImageView!
    
    var typePickerView: UIPickerView = UIPickerView()
    
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = halfTransparent
        view.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        return view
    }()
    
    var projectsArray = [String]()
    
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = offGrey
        
        self.projectsArray = ["Algorithms and Coding 1",
            "OOP",
            "Project: Digital Leash",
            "Project: Digital Clock",
            "Project: TableView",
            "Project: Navigation Control",
            "Project: Programmatic UI",
            "Project: Apple Maps",
            "Project: Google Maps/Google Places API",
            "Project: Animation",
            "Project: Facebook",
            "Project: Cloud and Camera",
            "Project: Slow-Mo Video"]

    }
    
    func setupViews() {
        // exit button
        let image = UIImage(named: "exit_icon.png")
        let tintedImage = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        exitButton.setImage(tintedImage, for: .normal)
        exitButton.tintColor = ashGrey
        
        // project pickerView
        self.view.addSubview(shadowView)
        self.view.addSubview(typePickerView)
        
        typePickerView.isHidden = true
        shadowView.isHidden = true
        typePickerView.dataSource = self
        typePickerView.delegate = self
        typePickerView.frame = CGRect(x: 0, y: windowHeight - 200, width: windowWidth, height: 200)
        typePickerView.layer.borderColor = ashGrey.cgColor
        typePickerView.layer.borderWidth = 1
        typePickerView.backgroundColor = .white

        jesseContainerView.layer.cornerRadius = 60
        jesseContainerView.layer.masksToBounds = true
        jesseContainerView.layer.borderWidth = 1
        jesseContainerView.layer.borderColor = borderGrey.cgColor
        jesseContainerView.backgroundColor = offGrey
        
        jesseImageView.layer.cornerRadius = 56
        jesseImageView.layer.masksToBounds = true
        
        projectButton.backgroundColor = .white
        projectButton.layer.cornerRadius = 5
        projectButton.layer.borderColor = borderGrey.cgColor
        projectButton.layer.borderWidth = 1
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int{
        return self.projectsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.projectsArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(self.projectsArray[row]) was selected.")
        self.projectButton.titleLabel?.text = self.projectsArray[row]
        typePickerView.isHidden = true
        shadowView.isHidden = true
    }
    
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 36.0
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 36.0
//    }

    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////
    @IBAction func submitButtonPrsd(_ sender: Any) {
        guard let projectName = self.projectButton.titleLabel?.text, let text = questionTextField.text else {
            print("form not valid")
            return
        }
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                let uid = user.uid
                let uuid = UUID().uuidString
                ref.child("Questions").child(uuid).setValue(["Project": projectName, "Question":text, "isAnswered":false, "askedBy":uid, "answeredBy":"N/A"])
            } else {
                // No User is signed in. Show user the login screen
            }
        }

    }
    
    @IBAction func projectBtn(_ sender: UIButton) {
        typePickerView.isHidden = false
        shadowView.isHidden = false
    }
    
    @IBAction func exitButtonPrsd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
