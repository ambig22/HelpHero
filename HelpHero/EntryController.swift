//
//  EntryController.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit

class EntryController: UIViewController {

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
    
    /////////////////////////////////////////////////////////////////
    //
    // viewDidLoad
    //
    /////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .white
        
        setupViews()
        
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
        self.navigationController?.pushViewController(creditVC, animated: true)
    }
    
}
