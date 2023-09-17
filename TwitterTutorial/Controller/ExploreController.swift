//
//  ExploreController.swift
//  TwitterTutorial
//
//  Created by 임재현 on 2023/09/15.
//

import UIKit

private let reuseIdentifier = "UserCell"

class ExploreController: UITableViewController {
    //MARK: - Properties
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    //MARK: - Helpers
    func configUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
    }
    
}

extension ExploreController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        return cell
    }
}
