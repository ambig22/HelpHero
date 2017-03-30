//
//  NewQuestionController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit

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

        self.typePickerView.isHidden = true
        self.typePickerView.dataSource = self
        self.typePickerView.delegate = self
        self.typePickerView.frame = CGRect(x: 100, y: 100, width: 100, height: 162)
        self.typePickerView.backgroundColor = UIColor.black
        self.typePickerView.layer.borderColor = UIColor.white.cgColor
        self.typePickerView.layer.borderWidth = 1
        
        self.view.addSubview(typePickerView)
        
        self.projectsArray = ["Project 1", "Project 2", "Project 3"]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.projectsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.projectsArray[row] as String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //typeBarButton.title = array[row]["type1"] as? String
        print("\(self.projectsArray[row]) was selected.")
        typePickerView.isHidden = true
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }

    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////
    @IBAction func submitButtonPrsd(_ sender: Any) {
        
    }

}
