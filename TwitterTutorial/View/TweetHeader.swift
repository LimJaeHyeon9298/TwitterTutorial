//
//  TweetHeader.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/18.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    //MARK: - Properties
    private lazy var profileImageVIew:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let fullnameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Lee Ji eun"
        return label
    }()
    
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "IU"
        return label
    }()
    
    private let captionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Some test caption from IU"
        return label
    }()
    
    private let dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "6:33 PM - 1/28/2023"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var optionsButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetsLabel: UILabel = {
        let label = UILabel()
        label.text = "2 Retweets"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Likes"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var statsView: UIView = {
        let view = UIView()
        let divider1 = UIView()
        divider1.backgroundColor = .lightGray
        view.addSubview(divider1)
        divider1.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingLeft: 8,height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel,likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor,paddingLeft: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .lightGray
        view.addSubview(divider2)
        divider2.anchor(left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,height: 1.0)
        
        return view
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel,usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [profileImageVIew,labelStack])
        stack.spacing = 12
        
        addSubview(stack)
        stack.anchor(top: topAnchor,left: leftAnchor,paddingTop: 16,paddingLeft: 16)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: stack.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 20,paddingLeft: 16,paddingRight: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionLabel.bottomAnchor,left: leftAnchor,paddingTop: 20,paddingLeft: 16)
        
        addSubview(optionsButton)
        optionsButton.centerY(inView: stack)
        optionsButton.anchor(right: rightAnchor,paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(top: dateLabel.bottomAnchor,left: leftAnchor,right: rightAnchor,paddingTop: 20,height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped() {
        print("hellop")
    }
    
    @objc func showActionSheet() {
        print("hi")
    }
}
