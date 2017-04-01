//
//  EntryController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase

class EntryController: UIViewController {
    
    var activeQuestion: Question?


    /////////////////////////////////////////////////////////////////
    //
    // UI Assets
    //
    /////////////////////////////////////////////////////////////////
    @IBOutlet weak var projectLabel: UILabel!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    @IBOutlet weak var resolvedButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var questionImageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        setupViews()
        
        if activeQuestion != nil {
            projectLabel.text = activeQuestion?.currentProject
            bodyTextView.text = activeQuestion?.question
            authorLabel.text = ""
            
            if activeQuestion?.answeredBy != nil {
                statusLabel.text = "RESOLVED"
            }
            
            if activeQuestion?.askedBy != FIRAuth.auth()?.currentUser?.uid {
                resolvedButton.isHidden = true
            }
        }
        
    }

    func setupViews() {
        questionImageView.image = questionImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        questionImageView.tintColor = ashGrey
        
        statusLabel.backgroundColor = borderGrey
        statusLabel.textColor = .white
        
        bodyTextView.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        bodyTextView.layer.borderColor = borderGrey.cgColor
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.cornerRadius = 5
        
        resolvedButton.backgroundColor = heroColor
        resolvedButton.setTitleColor(UIColor.white, for: .normal)
        resolvedButton.layer.cornerRadius = 5
    }
    
    /////////////////////////////////////////////////////////////////
    //
    // Actions
    //
    /////////////////////////////////////////////////////////////////
    @IBAction func resolvedButtonPrsd(_ sender: Any) {
        // present tableViewVC to pick the person that helped
        
        let creditVC = GiveCreditController()
        creditVC.activeQuestion = activeQuestion
        self.navigationController?.pushViewController(creditVC, animated: true)
    }
    
}
