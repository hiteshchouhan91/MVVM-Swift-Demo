//
//  ViewController.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userTableView : UITableView!
    
    private var userViewModel = UserViewModel()
    
    let cellReuseIdentifier = "userCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTableView.register(UINib(nibName: "UserTableCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        userViewModel.usersData.bind{ (_) in
            DispatchQueue.main.async {
                self.userTableView.reloadData()
            }
        }
    }
}

extension UserViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userViewModel.usersData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.userTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UserTableCell
        cell.userItem = self.userViewModel.usersData.value[indexPath.row]
        
        cell.markFavUser = { (id, status) in
            self.userViewModel.setFavUserStaus(id : id, status : status)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userDetailsController = storyboard.instantiateViewController(identifier: "UserDetailsViewController") as! UserDetailsViewController
        userDetailsController.userID = self.userViewModel.usersData.value[indexPath.row].id
        self.navigationController?.pushViewController(userDetailsController, animated: true)
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
}

