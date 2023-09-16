//
//  ProfileHeader.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/16.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
