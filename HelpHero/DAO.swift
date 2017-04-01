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
        
        let urlString = "https://helphero-7b63c.firebaseio.com/questions.json"
        
        //Check that the url is valid before trying to make a network call
        guard let url = URL(string: urlString)
            else {return}
        
        //Create a session (network session)
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            //print(response)
            
            //Get our json (data) and turn it into a dictionary
            //Check that we have data
            guard let myData:Data = data
                else {return}
            
            //Decode the raw data to a dictionary
            guard let json = try? JSONSerialization.jsonObject(with: myData, options: []) as! [String:AnyObject]
                else {return}

            for question in json {
                let valueDict = question.value
                if((valueDict["isAnswered"] as? Bool)! == false) {
                    let loadQuestion = Question(questionBody: (valueDict["question"] as? String)!, level: (valueDict["project"] as? String)!, answeredBy: (valueDict["answeredBy"] as? String)!, isAnswered: (valueDict["isAnswered"] as? Bool)!, askedBy: (valueDict["askedBy"] as? String)!, newuuid: question.key)
                    self.questionsArray.append(loadQuestion)
                }
                
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }.resume()
    }
    
    func downloadUsers(completion: @escaping () -> Void) {
        usersArray.removeAll()
        
        ref = FIRDatabase.database().reference()
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            let loadUser = User(snapshot: snapshot)
            self.usersArray.append(loadUser)
            completion()
        })
    }
    
    func reuploadQuestion(question:Question, completion: @escaping () -> Void)
    {
        ref = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                let uid = user.uid
                self.ref.child("questions").child(question.uuid).setValue(["project": question.currentProject!, "question":question.question!, "isAnswered":question.isAnswered!, "askedBy":uid, "answeredBy":question.answeredBy!])
                completion()
            } else {
                // No User is signed in. Show user the login screen
            }
        }
        
    }
    
    func answeredQuestion(currentQuestion:Question, answeredBy:User) {
        let answeredQ = currentQuestion
        answeredQ.isAnswered = true
        answeredQ.answeredBy = answeredBy.displayName
        
        reuploadQuestion(question: answeredQ, completion: {
            answeredBy.reputation += 1
            self.uploadUser(currentUser: answeredBy)
        })
    }
    
    func uploadUser(currentUser:User) {
        ref = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                let uid = user.uid
                self.ref.child("users").child(uid).setValue(["displayName": currentUser.displayName, "email": currentUser.email, "currentProject": currentUser.currentProject, "reputation":currentUser.reputation] as [String : Any])
            } else {
                // No User is signed in. Show user the login screen
            }
        }
    }
    
    func convertUID(uid:String, completion: @escaping (_ username:String) -> Void){
        ref = FIRDatabase.database().reference()
        
        var name:String = ""
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            print("Value is \(value as Any)")
            name = (value?["displayName"] as? String)!
            
            print("Reading From Firebase")
            
            print("Username: \(String(describing: name))")
            
            completion(name)
        })
        
        /*
        ref.child("users").child(uid).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value as Any)
            //name = (value?["displayName"] as? String)!
            
            print("Reading From Firebase")
            
            print("Username: \(String(describing: name))")
            
            completion(name)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        */
        
    }
}

