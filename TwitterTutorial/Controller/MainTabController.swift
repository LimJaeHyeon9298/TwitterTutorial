//
//  MainTabController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/15.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(handleActionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        uiTabBarSetting()
     
        authenticationUserAndConfigUI()
        view.backgroundColor = .twitterBlue
        //logUserOut()
    }
    //MARK: - API
    
    func authenticationUserAndConfigUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configUI()
            configureViewControllers()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Fail to sign out with error \(error.localizedDescription)")
        }
    }
    
    
    //MARK: - Selectors
    @objc func handleActionButtonTapped() {
        print(123)
    }
    
    //MARK: - Helpers
    
    func configUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingBottom: 64,paddingRight: 16,width: 56,height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
       
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
      
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image:UIImage(named: "like_unselected"), rootViewController: notifications)
       
      
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
       
        viewControllers = [nav1,nav2,nav3,nav4]
        
        
    }
    
    func uiTabBarSetting() {
        if #available(iOS 15.0 , *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
            
        }
    }
    
    func templateNavigationController(image:UIImage?,rootViewController:UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
      
        return nav
        
    }
    
    
    
}
