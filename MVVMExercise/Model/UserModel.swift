//
//  UserModel.swift
//  MVVMExercise
//
//  Created by Hitesh Chouhan on 03/02/21.
//  Copyright © 2021 Hitesh Chouhan. All rights reserved.
//

import Foundation

struct UserModel : Decodable  {
    var id : Int
    var name : String
    var username : String
    var email : String
    var phone : String
    var website : String
    var address : Address
    var company : Company
    var isFavUser : Bool?
}

struct Address : Decodable {
    var street : String
    var suite : String
    var city : String
    var zipcode : String
    var geo : Geo
}

struct Geo : Decodable {
    var lat : String
    var lng : String
}

struct Company : Decodable {
    var name : String
    var catchPhrase : String
    var bs : String
}
