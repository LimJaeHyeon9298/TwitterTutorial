//
//  UploadTweetViewModel.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/18.
//

import UIKit

enum UploadTweetConfiguartion {
    case tweet
    case reply(Tweet)
}

struct UploadTweetViewModel {
    let actionButtonTitle:String
    let placeholderText:String
    var shouldShowReplyLabel: Bool
    var replyText:String?
    
    init(config: UploadTweetConfiguartion) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's happening"
            shouldShowReplyLabel = false
        case .reply(let tweet):
            actionButtonTitle = "Tweet"
            placeholderText = "Tweet your reply"
            shouldShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
