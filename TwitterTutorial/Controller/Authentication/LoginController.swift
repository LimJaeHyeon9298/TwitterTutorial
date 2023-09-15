//
//  LoginController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/15.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let logoImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    //MARK: - Selector
    
    //MARK: - Helpers
    func configUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
    }
    
}
