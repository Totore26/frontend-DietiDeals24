//
//  Profile.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Amplify
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    let user: AuthUser
    let api = AccountRequest()
    
    @Published var imageProfile: UIImage?
    @Published var account: Account?
    @Published var showProfileSavedBanner: Bool = false

    init(user: AuthUser) {
        self.user = user
        getInfoBuyerAccount(username: user.username)
    }
    
    func getInfoBuyerAccount(username: String) {
        api.getInfoBuyerAccountAPI(completion: { result in
            switch result {
            case .success(let account):
                DispatchQueue.main.async {
                    self.account = account
                    print("GET INFO BUYER SUCCESS")
                    
                    // Stampiamo l'account ottenuto
                    if let encodedData = try? JSONEncoder().encode(account),
                       let jsonString = String(data: encodedData, encoding: .utf8) {
                        print("Account Details: \(jsonString)")
                    }
                }
            case .failure(let error):
                print("Failed to get buyer account info: \(error)")
            }
        }, username: username)
    }
    
    func callPhoneNumber() {
        if let phoneNumber = account?.telephoneNumber, let phoneURL = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
     
    func sendEmail() {
        if let email = account?.email, let emailURL = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
            }
        }
    }
     
    func openSocialLink(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    func isPersonalProfile() -> Bool {
        return user.username == account?.email
    }
    
    func saveChanges() {
        guard let updatedAccount = self.account else {
            print("\n\nError: Account is nil\n\n")
            return
        }
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(updatedAccount)
            
            api.modifyAccountAttributeAPI(json: jsonData) { success in
                if success {
                    DispatchQueue.main.async {
                        self.showProfileSavedBanner = true
                        self.getInfoBuyerAccount(username: self.user.username)
                    }
                }
            }
        } catch {
            print("Error encoding account to JSON: \(error)")
        }
    }   
}
