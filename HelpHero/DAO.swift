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
    
    func uploadUser(currentUser:User)
    {
        FIRAuth.auth()?.createUser(withEmail: currentUser.email, password: currentUser.password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                print("UID Error")
                return
            }
            
            // successfully authenticated user
            let ref = FIRDatabase.database().reference(fromURL: "https://helphero-7b63c.firebaseio.com/")
            let usersRef = ref.child("users").child(uid)
            let values = ["displayName": currentUser.username, "email": currentUser.email, "currentProject": currentUser.projectLevel, "reputation":0] as [String : Any]
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                
                print("Saved User Successfully into FIR DB")
            })
            
        })


    }
    
    func uploadQuestion(question:Question)
    {
        ref = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                let uid = user.uid
                let uuid = UUID().uuidString
                self.ref.child("Questions").child(uuid).setValue(["project": question.currentProject, "question":question.question, "isAnswered":false, "askedBy":uid, "answeredBy":question.answeredBy])
            } else {
                // No User is signed in. Show user the login screen
            }
        }

    }
    
    func downloadQuestions() {
        ref = FIRDatabase.database().reference()
        FIRDatabase.database().reference().child("Questions").observe(.childAdded, with: {(snapshot) in
            let loadQuestion = Question(snapshot: snapshot)
            print(loadQuestion)
        })
    }
    
    
    
    
    
}

