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
    
    @IBOutlet weak var submitButton: UIButton!
    
    var typePickerView: UIPickerView = UIPickerView()
    
    var projectsArray = [String]()
    
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.typePickerView.isHidden = true
        self.typePickerView.dataSource = self
        self.typePickerView.delegate = self
        self.typePickerView.frame = CGRect(x: ((self.view.frame.size.width)/2) - 150, y: ((self.view.frame.size.height)/2) - 200, width: (self.view.frame.size.width) * 0.90, height: ((self.view.frame.size.height) * 0.70))
        //self.typePickerView.backgroundColor = UIColor.black
        self.typePickerView.layer.borderColor = UIColor.black.cgColor
        self.typePickerView.layer.borderWidth = 1
        
        self.projectsArray = ["Project 1", "Project 2", "Project 3"]
        
        self.view.addSubview(typePickerView)
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
//        var handle: FIRAuthStateDidChangeListenerHandle?
//        handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
//            
//        }
        
        ref.child("Questions").child("Test").setValue(["Project": projectName, "Question":text])
        
    }
    
    @IBAction func projectBtn(_ sender: UIButton) {
        self.typePickerView.isHidden = false
    }
    

}
