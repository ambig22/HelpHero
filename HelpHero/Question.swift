//
//  Question.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit


class Question {
    var question:String
    var projectLevel:String
    var isAnswered:Bool = false
    var answeredBy:String = "N/A"
    var askedBy:String?
    
    init(questionBody:String, level:String)
    {
        question = questionBody
        projectLevel = level
        
    }
    
   
}
