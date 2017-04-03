//
//  NewQuestionController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase

class NewQuestionController: UIViewController {
  @IBOutlet weak var projectButton: UIButton!
  @IBOutlet weak var questionTextField: UITextField!
  @IBOutlet weak var exitButton: UIButton!
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet weak var jesseContainerView: UIView!
  @IBOutlet weak var jesseImageView: UIImageView!
  
  var sharedManager = DAO.sharedManager
  lazy var typePickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.isHidden = true
    pickerView.dataSource = self
    pickerView.delegate = self
    pickerView.frame = CGRect(x: 0, y: windowHeight - 200, width: windowWidth, height: 200)
    pickerView.layer.borderColor = ashGrey.cgColor
    pickerView.layer.borderWidth = 1
    pickerView.backgroundColor = .white
    return pickerView
  }()
  
  let shadowView: UIView = {
    let view = UIView()
    view.backgroundColor = halfTransparent
    view.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    questionTextField.delegate = self
    setupViews()
    view.backgroundColor = offGrey
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}

extension NewQuestionController: UITextFieldDelegate {
  func setupViews() {
    // MARK: exit button
    let image = UIImage(named: "exit_icon.png")
    let tintedImage = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    exitButton.setImage(tintedImage, for: .normal)
    exitButton.tintColor = ashGrey
    
    self.view.addSubview(shadowView)
    self.view.addSubview(typePickerView)
    shadowView.isHidden = true
    
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
    projectButton.setTitleColor(ashGrey, for: .normal)
    
    submitButton.backgroundColor = heroColor
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    sumbitWasSelected()
    return true
  }
  
  func sumbitWasSelected() {
    guard let projectName = self.projectButton.titleLabel?.text, var text = questionTextField.text else {
      print("form not valid")
      return
    }
    
    text = text.trimmingCharacters(in: .whitespaces)
    if text.characters.count == 0 { return }
    
    let newQuestion = Question(questionBody: text, level: projectName, answeredBy: "N/A", isAnswered: false, askedBy: "N/A")
    sharedManager.uploadQuestion(question: newQuestion)
    
    self.dismiss(animated: true, completion: nil)
  }
}

extension NewQuestionController: UIPickerViewDelegate, UIPickerViewDataSource {
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
    shadowView.isHidden = true
  }

  @IBAction func submitButtonPrsd(_ sender: Any) {
    sumbitWasSelected()
  }
  
  @IBAction func projectBtn(_ sender: UIButton) {
    typePickerView.isHidden = false
    shadowView.isHidden = false
  }
  
  @IBAction func exitButtonPrsd(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
