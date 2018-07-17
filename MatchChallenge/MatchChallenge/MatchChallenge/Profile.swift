//
//  Profile.swift
//  MatchChallenge
//
//  Created by Jogamaya Panigrahi on 7/13/18.
//  Copyright © 2018 Jogamaya Panigrahi. All rights reserved.
//

import Foundation
struct Profile:Codable {
    private enum keys : String, CodingKey {
        case results = "results"
    }
    let results:[Result]
}
struct Result:Codable {
    private enum keys : String, CodingKey {
        case gender = "gender"
        case name = "name"
        case email = "email"
        case dob = "dob"
        case phone = "phone"
        case picture = "picture"
        case nat = "nat"
        
    }
    let gender:String
    let name :Name
    let email:String
    let dob:DOB
    let phone:String
    let picture:Picture
    let nat:String

}
struct Name:Codable {
    private enum keys : String, CodingKey {
        case title = "title"
        case first = "first"
        case last = "last"
    }
    let title:String
    let first:String
    let last:String
}
struct Picture:Codable {
    private enum keys : String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }
    let large:String
    let medium:String
    let thumbnail:String
}
struct DOB:Codable {
    private enum keys : String, CodingKey {
        case date = "date"
        case age = "age"
    }
    let date:String
    let age:Int
}
class ProfileDataSingleton{
    var cellsHighlighted:[IndexPath] = []
    static let sharedInstance = ProfileDataSingleton()
    func reset(){
        self.cellsHighlighted = []
    }
}
