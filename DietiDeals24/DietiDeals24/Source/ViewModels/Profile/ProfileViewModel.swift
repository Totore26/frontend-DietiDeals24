//
//  Profile.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Amplify
import SwiftUI

class ProfileViewModel : ObservableObject {
    
    let user : AuthUser
    
    @Published var fullName: String = ""
    @Published var description: String = ""
    @Published var country: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var facebookURL: String = ""
    @Published var twitterURL: String = ""
    
    init(user: AuthUser) {
        self.user = user
    }
    
    func fetchDataProfile(fullName: String, description: String, country: String, phoneNumber: String, email: String, facebookURL: String, twitterURL: String) {
        self.fullName = fullName
        self.description = description
        self.country = country
        self.phoneNumber = phoneNumber
        self.email = email
        self.facebookURL = facebookURL
        self.twitterURL = twitterURL
    }
    
    func callPhoneNumber() {
         if let phoneURL = URL(string: "tel://\(phoneNumber)") {
             UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
         }
     }
     
     func sendEmail() {
         if let emailURL = URL(string: "mailto:\(email)") {
             if UIApplication.shared.canOpenURL(emailURL) {
                 UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
             }
         }
     }
     
     func openFacebook() {
         if let url = URL(string: facebookURL) {
             UIApplication.shared.open(url)
         }
     }
     
     func openTwitter() {
         if let url = URL(string: twitterURL) {
             UIApplication.shared.open(url)
         }
     }
    
}
