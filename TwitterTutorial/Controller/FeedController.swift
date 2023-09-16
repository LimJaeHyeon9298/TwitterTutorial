//
//  FeedController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/15.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    //MARK: - Properties
    
    var user:User? {
        didSet {
            configureLeftBarButton()
            
        }
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        configUI()
 
    }
    
    //MARK: - Helpers
   
    func configUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        
       
    }
   
    func configureLeftBarButton() {
        guard let user = user else {return}
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
   
     
        profileImageView.sd_setImage(with: user.profileImageUrl,completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
