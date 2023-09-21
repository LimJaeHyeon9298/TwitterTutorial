//
//  EditProfileFooter.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/21.
//

import UIKit

protocol EditProfileFooterDelegate: AnyObject {
    func handleLogout()
}

class EditProfileFooter: UIView {
    //MARK: - Properties
    
    weak var delegate: EditProfileFooterDelegate?
    
    private lazy var logoutButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoutButton)
       // logoutButton.addConstraintsToFillView(self)
//        logoutButton.center(inView: self)
        //logoutButton.setDimensions(width: frame.width, height: 50)
        logoutButton.anchor(left: leftAnchor,right:rightAnchor,paddingLeft: 16,paddingRight: 16)
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.centerY(inView: self)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Selectors
    @objc func handleLogout() {
        delegate?.handleLogout()
    }
    //MARK: - Helpers
    
}
