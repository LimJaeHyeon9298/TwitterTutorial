//
//  UploadTweetController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/16.
//

import UIKit
import ActiveLabel


class UploadTweetController: UIViewController {
    //MARK: - Properties
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
   
    private lazy var actionButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private let profileImageVIew:UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private lazy var replyLabel:ActiveLabel = {
       let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.mentionColor = .twitterBlue
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        return label
    }()
    
    
    
    private let captionTextView = InputTextView()
    
    //MARK: - Lifecycle
    init(user:User,config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureMentionHandler()
       
      
        
    }
    
    //MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else {return}
        TweetService.shared.uploadTweet(caption: caption, type: config) { error, ref in
            if let error = error {
                print("Error is \(error.localizedDescription)")
                return
           }
            if case .reply(let tweet) = self.config {
                NotificationService.shared.uploadNotification(toUser:tweet.user,type: .reply,tweetID: tweet.tweetID )
            }
            
            self.dismiss(animated: true)
        }
    }
    
    //MARK: - API
    
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        configNavigationBar()
       
//        view.addSubview(profileImageVIew)
//        profileImageVIew.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,paddingTop: 16,paddingLeft: 16)
       profileImageVIew.sd_setImage(with: user.profileImageUrl)
        
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageVIew,captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel,imageCaptionStack])
        stack.axis = .vertical
//        stack.alignment = .leading
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 16,paddingLeft: 16,paddingRight: 16)
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replytext = viewModel.replyText else {return}
        replyLabel.text = replytext
        
    }
    
   
    
    func configNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    func configureMentionHandler() {
        replyLabel.handleMentionTap { mention in
            print("menton use is \(mention)")
        }
    }
    
    
    
}

