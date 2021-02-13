//
//  UserViewModel.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import Foundation

class UserViewModel {
    
    var usersData : Observable<[UserModel]> = Observable([])
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)
    
    init() {
        fetchUsers()
        DataManager.shared.users.bind { (_) in
            self.usersData = DataManager.shared.users
        }
    }
    
    func fetchUsers() {
        APIManager.shared.fetchUsersDetail { result in
            switch result {
            case .success(let users):
                self.usersData.value = users
                return
            case .failure(let error):
                if (error == .parsingError) {
                    self.setError("Failed to parse the response data")
                } else if (error == .connectionError) {
                    self.setError("No Internet connection, please check internet and try again")
                } else if (error == .responseError) {
                    self.setError("Failed to get user list")
                }
            }
        }
    }
    
    func setFavUserStaus(id : Int, status : Bool) {
        if let index = self.usersData.value.firstIndex(where: {$0.id == id}) {
             _ = DataManager.shared.updateFavourite(id: id)
            self.usersData.value[index].isFavUser = status           
        }
    }
    
    func setError(_ message: String) {
        self.errorMessage = Observable(message)
        self.error = Observable(true)
    }
}
