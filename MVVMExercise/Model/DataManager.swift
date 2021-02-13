//
//  DataManager.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import Foundation

class DataManager {
    
    var users : Observable<[UserModel]> = Observable([]);
    static let shared = DataManager()

    private init() {
    }
    
    func setUsers(users : [UserModel]) {
        self.users.value = users
    }
    
    func getUsers() -> [UserModel] {
        return self.users.value
    }
    
    func getUserForID(id : Int) -> UserModel? {
        if let usr = self.users.value.first(where: {$0.id == id}) {
            return usr
        } else {
            return nil
        }
    }
    
    func updateFavourite(id : Int) -> Bool {
        if let index = self.users.value.firstIndex(where: {$0.id == id}) {
            let isFav = self.users.value[index].isFavUser ?? false
            self.users.value[index].isFavUser = !isFav
            return !isFav
        }
        return false
    }
}
