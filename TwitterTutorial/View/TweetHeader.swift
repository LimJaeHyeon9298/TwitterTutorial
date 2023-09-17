//
//  TweetHeader.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/18.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
}
