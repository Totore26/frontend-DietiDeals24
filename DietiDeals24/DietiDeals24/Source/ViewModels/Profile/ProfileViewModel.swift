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
    let api = AccountRequest()
    
    @Published var fullName: String = ""
    @Published var description: String = ""
    @Published var country: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var link1: String = ""
    @Published var link2: String = ""
    
    
    
    init(user: AuthUser) {
        self.user = user
        getInfoBuyerAccount(username: user.username)
    }
    
    private func getInfoBuyerAccount(username: String) {
        api.getInfoBuyerAccountAPI(completion: { result in
            switch result {
            case .success(let account):
                DispatchQueue.main.async {
                    self.fullName = account.fullName
                    self.description = account.description ?? "not aviable"
                    self.country = account.country ?? "country not aviable"
                    self.phoneNumber = account.telephoneNumber
                    self.email = account.email
                    // Assumi che ci siano solo due social links (Facebook e Twitter)
                    if let socialLinks = account.socialLinks {
                        if socialLinks.count > 0 {
                            self.link1 = socialLinks[0].link ?? ""
                        }
                        if socialLinks.count > 1 {
                            self.link2 = socialLinks[1].link ?? ""
                        }
                    }
                    print("GET INFO BUYER SUCCESS")
                }
            case .failure(let error):
                print("Failed to get buyer account info: \(error)")
            }
        }, username: username)
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
         if let url = URL(string: link1) {
             UIApplication.shared.open(url)
         }
     }
     
     func openTwitter() {
         if let url = URL(string: link2) {
             UIApplication.shared.open(url)
         }
     }
    
    func isPersonalProfile() -> Bool {
        return user.username == email
    }
    
}
