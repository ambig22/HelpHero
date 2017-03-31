//
//  RegisterController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase



class CustomTextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .white
        self.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        self.textColor = ashGrey
        self.layer.cornerRadius = 5
    }
}

class RegisterController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
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
    
    @IBOutlet weak var projectButton: UIButton!
    
    var sharedManager = DAO.sharedManager
    
    var typePickerView: UIPickerView = UIPickerView()

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
        
        projectButton.setTitleColor(ashGrey, for: .normal)
        
        self.view.addSubview(typePickerView)
        
        typePickerView.isHidden = true
        typePickerView.dataSource = self
        typePickerView.delegate = self
        typePickerView.frame = CGRect(x: 0, y: windowHeight - 200, width: windowWidth, height: 200)
        typePickerView.layer.borderColor = ashGrey.cgColor
        typePickerView.layer.borderWidth = 1
        typePickerView.backgroundColor = .white
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int{
        return projectsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projectsArray[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("\(projectsArray[row]) was selected.")
        projectButton.titleLabel?.text = projectsArray[row]
        typePickerView.isHidden = true
    }

    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////

    @IBAction func projectButtonPrsd(_ sender: Any) {
        typePickerView.isHidden = false
    }
    
    
    @IBAction func registerBtn(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = displayNameTextField.text, let projectLevel = projectButton.titleLabel?.text else {
            print("form not valid")
            return
        }
        
//        let newUser = User(name: name, level: projectLevel, email: email, password: password, reputation: 0.0)
//        sharedManager.uploadUser(currentUser: newUser)
         self.dismiss(animated: true, completion: nil)
    }
    
}
