//
//  UserDetailsViewModel.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import Foundation

struct UserDetailsViewModel {
    
    var userDetails : Observable<UserModel?> = Observable(nil)
    
    init(userId : Int) {
        self.userDetails.value = DataManager.shared.getUserForID(id: userId)!
    }

    func getFullAddress() -> String {
        guard let address = self.userDetails.value?.address else {
            return ""
        }
        return address.street + ", " + address.suite + ", " + address.city + ", " + address.zipcode
    }

    func getCompanyDetails() -> String {
        
        guard let company = self.userDetails.value?.company else {
            return ""
        }
        return company.name + ", " + company.catchPhrase + ", " + company.bs
    }
    
    func setFavUserStaus(id : Int) {
         _ = DataManager.shared.updateFavourite(id: id)
        if self.userDetails.value?.isFavUser == nil || self.userDetails.value?.isFavUser == false {
            self.userDetails.value?.isFavUser = true
        } else {
            self.userDetails.value?.isFavUser = false
        }
    }
}
