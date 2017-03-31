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
                self.ref.child("questions").child(uuid).setValue(["project": question.currentProject, "question":question.question, "isAnswered":false, "askedBy":uid, "answeredBy":question.answeredBy])
            } else {
                // No User is signed in. Show user the login screen
            }
        }

    }
    
    func downloadQuestions() {
        ref = FIRDatabase.database().reference()
        FIRDatabase.database().reference().child("questions").observe(.childAdded, with: {(snapshot) in
            let loadQuestion = Question(snapshot: snapshot)
            print(loadQuestion)
        })
    }
    
    func downloadUsers() {
        ref = FIRDatabase.database().reference()
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            let loadUser = User(snapshot: snapshot)
            print(loadUser)
        })
    }
    
    
    
}

