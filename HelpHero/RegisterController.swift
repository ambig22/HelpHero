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

class RegisterController: UIViewController  {
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var displayNameTextField: CustomTextField!
  @IBOutlet weak var emailTextField: CustomTextField!
  @IBOutlet weak var passwordTextField: CustomTextField!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var projectButton: UIButton!
  
  var sharedManager = DAO.sharedManager
  var typePickerView: UIPickerView = UIPickerView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    view.backgroundColor = offGrey
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
}

extension RegisterController: UIPickerViewDelegate, UIPickerViewDataSource {
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
  
  
  @IBAction func projectButtonPrsd(_ sender: Any) {
    typePickerView.isHidden = false
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  @IBAction func registerBtn(_ sender: UIButton) {
    guard let email = emailTextField.text, let password = passwordTextField.text, let name = displayNameTextField.text, let currentProject = projectButton.titleLabel?.text else {
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
      
      let ref = FIRDatabase.database().reference(fromURL: "https://helphero-7b63c.firebaseio.com/")
      let usersRef = ref.child("users").child(uid)
      let values = ["displayName": name, "email": email, "currentProject": currentProject, "reputation":0] as [String : Any]
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
