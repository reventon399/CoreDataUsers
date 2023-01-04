//
//  Model.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 30.12.2022.
//

import Foundation

enum Genders: String {
    case male = "male"
    case female = "female"
}

struct UsersModel {
    var name: String
    var gender: Genders
    var image: String
}
