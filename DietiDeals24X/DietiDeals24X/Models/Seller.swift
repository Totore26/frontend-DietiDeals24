//
//  Seller.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

import Foundation



class Seller : Account {
    
    var notifications : Array<Notification>?
    
    var socialLinks : Array<SocialLink>?
    
    var auctionGenereted : Array<Auction>?
    
    var fullName : String
    
    var imageAccount : String?
    
    var email : String
    
    var password : String
    
    var description : String?
    
    var telephoneNumber : String
    
    var country : String?
    
    
    init(fullName: String, imageAccount: String? = nil, email: String, password: String, description: String? = nil, telephoneNumber: String, country: String? = nil) {
        self.fullName = fullName
        self.imageAccount = imageAccount
        self.email = email
        self.password = password
        self.description = description
        self.telephoneNumber = telephoneNumber
        self.country = country
    }
    
    
    func getAllNotification() {

    }
    
    
}
