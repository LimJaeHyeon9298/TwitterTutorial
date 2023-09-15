//
//  AuthService.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/16.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email:String
    let password:String
    let fullname:String
    let username:String
    let profileImage:UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func registerUser(credentials:AuthCredentials,completion:@escaping(Error?,DatabaseReference)->Void) {
        
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        let fullname = credentials.fullname
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGE.child(filename)
        
        
        storageRef.putData(imageData) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageURL = url?.absoluteString else {return}
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    let values = ["email":email,"username":username,"fullname":fullname,"profileImage":profileImageURL]
                   
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                   
                  
                    
                }
               
              
            }
         
            
        }
    }
    
    
}
