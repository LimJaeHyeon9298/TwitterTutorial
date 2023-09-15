//
//  User.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/16.
//

import Foundation

struct User {
    let fullname:String
    let email:String
    let username:String
    var profileImageUrl : URL?
    let uid : String
    
    
    init(uid:String,dictionary:[String:AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let profileURLString = dictionary["profileImage"] as? String {
            guard let url = URL(string: profileURLString) else {return}
            self.profileImageUrl = url
        }
      
    }
    
    
    
}
