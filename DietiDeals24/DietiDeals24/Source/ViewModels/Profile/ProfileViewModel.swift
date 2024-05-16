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
    
    @Published var imageProfile: UIImage?
    @Published var account: Account?
    @Published var showProfileSavedBanner: Bool = false
    @Published var showPasswordErrorBanner: Bool = false
    let api = AccountRequest()
    let user: String
    var modifyAccount : Bool
    
    init(user: String, isSellerSession : Bool, modifyAccount : Bool) {
        self.modifyAccount = modifyAccount
        self.user = user
        if(modifyAccount){
            getInfoBuyerAccount(username: user)
        }
        else {
            getInfoSellerAccount(username: user)
        }
    }
    
    func getProfilePhoto() {
        do {
            try fetchProfilePhoto(email: user)
        } catch {
            print("\n\nErrore nel download della foto profilo\n\n")
        }
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
    
    
    func getInfoSellerAccount(username: String) {
        api.getInfoSellerAccountAPI(completion: { result in
            switch result {
            case .success(let account):
                DispatchQueue.main.async {
                    self.account = account
                    print("GET INFO SELLER SUCCESS")
                    
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
        return modifyAccount
    }
    
    func saveChanges(isSellerSession: Bool) {
        guard let updatedAccount = self.account else {
            print("\n\nError: Account is nil\n\n")
            return
        }
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(updatedAccount)
            
            if isSellerSession {
                api.modifySellerAccountAttributeAPI(json: jsonData) { success in
                    if success {
                        DispatchQueue.main.async {
                            self.showProfileSavedBanner = true
                            self.getInfoSellerAccount(username: self.user)
                        }
                    }
                }
            } else {
                api.modifyBuyerAccountAttributeAPI(json: jsonData) { success in
                    if success {
                        DispatchQueue.main.async {
                            self.showProfileSavedBanner = true
                            self.getInfoBuyerAccount(username: self.user)
                        }
                    }
                }
            }
        } catch {
            print("Error encoding account to JSON: \(error)")
        }
    }
}
