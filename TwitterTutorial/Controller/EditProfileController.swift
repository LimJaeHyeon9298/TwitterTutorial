//
//  EditProfileController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/21.
//

import UIKit

class EditProfileController: UITableViewController {
    //MARK: - Properties
    private let user: User
    //MARK: - Lifecycle
  
    init(user:User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    
    
    //MARK: - Selector
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapDone() {
        dismiss(animated: true)
    }
    //MARK: - API
    
    //MARK: - Helpers
    private func configureNavigationBar() {
    if #available(iOS 15.0, *) {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .twitterBlue
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
     
    } else {
    navigationController?.navigationBar.barTintColor = .twitterBlue
    }
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = false
     
    navigationItem.title = "Edit Profile"
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    navigationItem.rightBarButtonItem?.isEnabled = false
    }
  
}
