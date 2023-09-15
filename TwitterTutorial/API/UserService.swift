//
//  UserService.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/16.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
            print("dictionary is \(dictionary)")
            
            guard let username = dictionary["username"] as? String else {return}
           
          
            let user = User(uid: uid, dictionary: dictionary)
            
            print("username is \(user.username)")
            print("username is \(user.fullname)")
        }
     
    }
}
