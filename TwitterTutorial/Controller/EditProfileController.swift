//
//  EditProfileController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/21.
//

import UIKit

private let reuseIdentifier = "EditProfileCell"

protocol EditProfileControllerDelegate:AnyObject {
    func controller(_ controller: EditProfileController,wantsToupdate user: User)
    func handleLogout()
}

class EditProfileController: UITableViewController {
    //MARK: - Properties
    private var user: User
    private lazy var headerView = EditProfileHeader(user: user)
    private let footerView = EditProfileFooter()
    private let imagePicker = UIImagePickerController()
    private var userInfoChanged = false
    weak var delegate: EditProfileControllerDelegate?
    
    private var imageChanged: Bool {
        return selectedImage != nil
    }
    
    private var selectedImage: UIImage? {
        didSet{headerView.profileImageView.image = selectedImage}
    }
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
        configureTableView()
        configureImagePicker()
     
        
    }
    
    
    
    //MARK: - Selector
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapDone() {
        view.endEditing(true)
        guard imageChanged || userInfoChanged else {return}
        updateUserData()
    }
    //MARK: - API
    func updateUserData() {
        if imageChanged && !userInfoChanged {
            print("changed image and not data")
            updateProfileImage()
            
        }
            
        if userInfoChanged && !imageChanged {
            print("changed data and not image")
            UserService.shared.saveUserData(user: user) { error, ref in
                self.delegate?.controller(self, wantsToupdate: self.user)
            }
        }
        
        if userInfoChanged && imageChanged {
            print("changed both")
            UserService.shared.saveUserData(user: user) { error, ref in
                self.updateProfileImage()
            }
        }
        
        
        
    }
    
    func updateProfileImage() {
        guard let image = selectedImage else {return}
        
        UserService.shared.updateProfileImage(image: image) { profileImageUrl in
            self.user.profileImageUrl = profileImageUrl
            self.delegate?.controller(self, wantsToupdate: self.user)
        }
    }
    
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
   
    }
    
    func configureTableView() {
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
        footerView.delegate = self
        headerView.delegate = self
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .white
        
    }
  
    func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    
}
//MARK: - UITableViewDelegate
extension EditProfileController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0 }
        
        return option == .bio ? 100 : 48
    }
}


//MARK: - UITableViewDataSource
extension EditProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfileOptions.allCases.count
    }
      
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
        guard let option = EditProfileOptions(rawValue: indexPath.row) else {return cell}
        cell.viewModel = EditProfileViewModel(user: user, option: option)
        cell.delegate = self
        return cell
    }
    
}


//MARK: - EditProfileHeaderDelegate
extension EditProfileController : EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
       present(imagePicker, animated: true)
    }
    
    
}
//MARK: - UIImagePickerControllerDelegate
extension EditProfileController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        guard let image = info[.editedImage] as? UIImage else {return}
        self.selectedImage = image
        
        dismiss(animated: true)
    }
}
//MARK: - EditProfileCellDelegate
extension EditProfileController: EditProfileCellDelegate {
    func updateUserInfo(_ cell: EditProfileCell) {
        guard let viewModel = cell.viewModel else {return}
        userInfoChanged = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        switch viewModel.option {
            
        case .fullname:
            guard let fullname = cell.infoTextField.text else {return}
            user.fullname = fullname
        case .username:
            guard let username = cell.infoTextField.text else {return}
            user.username = username
        case .bio:
            user.bio = cell.bioTextView.text
        }
      
    }
    
    
}
//MARK: - EditProfileFooterDelegate
extension EditProfileController: EditProfileFooterDelegate {
    func handleLogout() {
        
        let alert = UIAlertController(title: nil, message: "진짜로 로그아웃 하시겠습니까?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive,handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        self.present(alert, animated: true)
        
    }
}
