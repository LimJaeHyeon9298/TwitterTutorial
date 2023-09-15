//
//  ConversationsController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/15.
//

import UIKit

class ConversationsController: UIViewController {
    //MARK: - Properties
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

      configUI()
    }
    
    //MARK: - Helpers
    
    func configUI() {
        view.backgroundColor = .white
        navigationItem.title = "Message"
    }
    
    
}

