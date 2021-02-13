//
//  UserDetailsViewController.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import UIKit

class UserDetailsViewController : UIViewController {
    
    var userID : Int!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var username : UILabel!
    @IBOutlet weak var addressDetails : UILabel!
    @IBOutlet weak var companyDetails : UILabel!
    @IBOutlet weak var phone : UILabel!
    @IBOutlet weak var webSite : UITextView!
    @IBOutlet weak var favButton: UIBarButtonItem!
    
    private var viewModel : UserDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UserDetailsViewModel(userId: self.userID)
        self.webSite.isEditable = false;
        self.webSite.dataDetectorTypes = .all;
        viewModel.userDetails.bind { (_) in
            self.populateData()
        }
    }
    
    func populateData() {
        self.name.text = self.viewModel.userDetails.value?.name
        self.username.text = self.viewModel.userDetails.value?.username
        self.addressDetails.text = self.viewModel.getFullAddress()
        self.companyDetails.text = self.viewModel.getCompanyDetails()
        self.phone.text = self.viewModel.userDetails.value?.phone
        self.webSite.text = self.viewModel.userDetails.value?.website
        self.setFavStar(isFav: self.viewModel.userDetails.value?.isFavUser)
    }
    
    @IBAction func markAsFavourite() {
        self.viewModel.setFavUserStaus(id : self.userID)
    }
    
    func setFavStar(isFav : Bool?) {
        guard let fav = isFav else {
            return
        }
        if (fav) {
            self.favButton.image = UIImage(systemName: "star.fill")
        } else {
            self.favButton.image = UIImage(systemName: "star")
        }
    }
}
