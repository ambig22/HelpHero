//
//  Question.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase


class Question {
    var question:String?
    var currentProject:String?
    var isAnswered:Bool?
    var answeredBy:String?
    var askedBy:String?
    var uuid:String = "123"
    
    var sharedManager = DAO.sharedManager
    
    init(questionBody:String, level:String, answeredBy:String, isAnswered:Bool, askedBy:String)
    {
        question = questionBody
        currentProject = level
        self.askedBy = askedBy
        self.answeredBy = answeredBy
        self.isAnswered = isAnswered
        
    }
    
    init(questionBody:String, level:String, answeredBy:String, isAnswered:Bool, askedBy:String, newuuid:String)
    {
        question = questionBody
        currentProject = level
        self.askedBy = askedBy
        self.answeredBy = answeredBy
        self.isAnswered = isAnswered
        self.uuid = newuuid
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value as? NSDictionary
        self.isAnswered = value?["isAnswered"] as? Bool
        self.uuid = snapshot.key
        //print("The uuid is: \(uuid)")
        self.question = value?["question"] as? String
        self.currentProject = value?["project"] as? String
        self.answeredBy = value?["answeredBy"] as? String
        self.askedBy = value?["askedBy"] as? String
        
        //let loadQuestion = Question(questionBody: self.question!, level: self.currentProject!, answeredBy: self.answeredBy!, isAnswered: self.isAnswered!, askedBy: self.answeredBy!, newuuid: self.uuid)
        print("Num of questions \(sharedManager.questionsArray.count)")
        
    }
    
   
}
