//
//  Account.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

protocol Account: Codable {
    
    var notifications : Array <Notification>? {get set}
    
    var socialLinks : Array <SocialLink>? {get set}
    
    var fullName : String {get set}
    
    var imageAccount : String? {get set}
    
    var email : String {get set}
    
    var password : String {get set}
    
    var description : String? {get set}
    
    var telephoneNumber : String {get set}
    
    var country : String? {get set}
    

    
}
