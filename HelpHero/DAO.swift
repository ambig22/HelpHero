//
//  DAO.swift
//  HelpHero
//
//  Created by Jerry Chen on 3/30/17.
//  Copyright © 2017 Jerry Chen. All rights reserved.
//

import UIKit
import Firebase


class DAO {
    static let sharedManager = DAO()
    var ref: FIRDatabaseReference!
    var questionsArray = [Question]()
    var usersArray = [User]()
    
    
    func uploadQuestion(question:Question)
    {
        ref = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                let uid = user.uid
                let uuid = UUID().uuidString
                self.ref.child("questions").child(uuid).setValue(["project": question.currentProject!, "question":question.question!, "isAnswered":question.isAnswered!, "askedBy":uid, "answeredBy":question.answeredBy!])
            } else {
                // No User is signed in. Show user the login screen
            }
        }

    }
    
    func downloadQuestions(completion: @escaping () -> Void) {
        questionsArray.removeAll()
        
        ref = FIRDatabase.database().reference()
        FIRDatabase.database().reference().child("questions").observe(.childAdded, with: {(snapshot) in
            let loadQuestion = Question(snapshot: snapshot)
            print(loadQuestion)
            completion()
        })
    }
    
    func downloadUsers(completion: @escaping () -> Void) {
        usersArray.removeAll()
        
        ref = FIRDatabase.database().reference()
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            let loadUser = User(snapshot: snapshot)
            print(loadUser)
            completion()
        })
        
        print("completed??????????????????????")
    }
    
    func reuploadQuestion(question:Question)
    {
        ref = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                let uid = user.uid
                self.ref.child("questions").child(question.uuid).setValue(["project": question.currentProject!, "question":question.question!, "isAnswered":question.isAnswered!, "askedBy":uid, "answeredBy":question.answeredBy!])
            } else {
                // No User is signed in. Show user the login screen
            }
        }
        
    }
    
    func answeredQuestion(currentQuestion:Question, answeredBy:String) {
        let answeredQ = currentQuestion
        answeredQ.isAnswered = true
        answeredQ.answeredBy = answeredBy
        
        reuploadQuestion(question: answeredQ)
    }
    
}

