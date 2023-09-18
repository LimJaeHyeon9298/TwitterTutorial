//
//  Tweet.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/16.
//

import Foundation

struct Tweet {
    let caption:String
    let tweetID:String
    let uid:String
    var likes:Int
    var timestamp:Date!
    let retweetCount:Int
    var user:User
    var didLike = false
    
    init(user:User,tweetID:String, dicionary: [String:Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dicionary["caption"] as? String ?? ""
        self.uid = dicionary["uid"] as? String ?? ""
        self.likes = dicionary["likes"] as? Int ?? 0
        self.retweetCount = dicionary["retweets"] as? Int ?? 0
       
        if let timestamp = dicionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
