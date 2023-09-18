//
//  UploadTweetController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/16.
//

import UIKit


class UploadTweetController: UIViewController {
    //MARK: - Properties
    private let user: User
    private let config: UploadTweetConfiguartion
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
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - Lifecycle
    init(user:User,config: UploadTweetConfiguartion) {
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
       
        switch config {
        case .tweet:
            print("tweet")
        case .reply(let tweet) :
            print("replying\(tweet.caption)")
        }
        
    }
    
    //MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else {return}
        TweetService.shared.uploadTweet(caption: caption) { error, ref in
            if let error = error {
                print("Error is \(error.localizedDescription)")
                return
           }
            self.dismiss(animated: true)
        }
    }
    
    //MARK: - API
    
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        configNavigationBar()
       
        view.addSubview(profileImageVIew)
        profileImageVIew.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,paddingTop: 16,paddingLeft: 16)
        profileImageVIew.sd_setImage(with: user.profileImageUrl)
        
        let stack = UIStackView(arrangedSubviews: [profileImageVIew,captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .leading
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 16,paddingLeft: 16,paddingRight: 16)
        
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

    
    
    
}

