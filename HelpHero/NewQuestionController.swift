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
    
    var sharedManager = DAO.sharedManager
    
    var typePickerView: UIPickerView = UIPickerView()
    
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = halfTransparent
        view.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        return view
    }()
    
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = offGrey

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
        projectButton.setTitleColor(ashGrey, for: .normal)
        
        submitButton.backgroundColor = heroColor
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
        let newQuestion = Question(questionBody: text, level: projectName, answeredBy: "N/A", isAnswered: false, askedBy: "N/A")
        sharedManager.uploadQuestion(question: newQuestion)
    }
    
    @IBAction func projectBtn(_ sender: UIButton) {
        typePickerView.isHidden = false
        shadowView.isHidden = false
    }
    
    @IBAction func exitButtonPrsd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
