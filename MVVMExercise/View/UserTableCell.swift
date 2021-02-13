//
//  UserTableCell.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var phone : UILabel!
    @IBOutlet weak var webSite : UITextView!
    @IBOutlet weak var companyName : UILabel!
    @IBOutlet weak var isFavStar: UIButton!
    var id: Int!
    
    var userItem : UserModel! {
        didSet {
            self.id = userItem.id
            self.name.text = userItem.name
            self.phone.text = userItem.phone
            self.webSite.text = userItem.website
            self.companyName.text = userItem.company.name
            if userItem.isFavUser == nil || userItem.isFavUser == false {
                self.isFavStar.isSelected = false
            } else {
                self.isFavStar.isSelected = true
            }
        }
    }
    
    var markFavUser : ((Int,Bool) -> Void)?

    @IBAction func toggleFav() {
        markFavUser?(self.id,!self.isFavStar.isSelected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.webSite.isEditable = false;
        self.webSite.dataDetectorTypes = .all;
        self.isFavStar.setImage(UIImage(systemName: "star.fill"),for: .selected)
        self.isFavStar.setImage(UIImage(systemName: "star"),for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
