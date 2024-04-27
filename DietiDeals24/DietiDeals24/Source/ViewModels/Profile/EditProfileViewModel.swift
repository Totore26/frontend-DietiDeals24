//
//  EditProfile.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

/*
import Foundation
import SwiftUI
import Combine

class EditProfileViewModel: ObservableObject {
    
    let api = AccountRequest()
    
    @Published var profileImage: UIImage?
    @Published var fullName: String
    @Published var nationality: String
    @Published var description: String
    @Published var showProfileSavedBanner: Bool
    @Published var link1: String
    @Published var link2: String
    @Published var telephoneNumber: String
    @Published var account: Account
    
    init(account: Account) {
        self.account = account
        self.profileImage = nil
        self.fullName = account.fullName
        self.nationality = account.country ?? ""
        self.description = account.description ?? ""
        self.showProfileSavedBanner = false
        self.link1 = account.socialLinks?.first?.link ?? ""
        self.link2 = account.socialLinks?.dropFirst().first?.link ?? ""
        self.telephoneNumber = account.telephoneNumber
    }
    
    func saveChanges() {
        var updatedAccount = self.account
        updatedAccount.fullName = fullName
        updatedAccount.country = nationality
        updatedAccount.description = description
        updatedAccount.telephoneNumber = telephoneNumber
        
        // Aggiorna i link social solo se sono stati modificati dall'utente
        if var socialLinks = updatedAccount.socialLinks {
            if socialLinks.indices.contains(0) {
                socialLinks[0].link = link1
            }
            if socialLinks.indices.contains(1) {
                socialLinks[1].link = link2
            }
            updatedAccount.socialLinks = socialLinks
        }

        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(updatedAccount)
            
            api.modifyAccountAttributeAPI(json: jsonData) { success in
                if success {
                    DispatchQueue.main.async {
                        self.account = updatedAccount
                        self.showProfileSavedBanner = true
                        
                        //aggiorna profileviewmodel
                        ProfileUpdatePublisher.shared.sendUpdate()
                    }
                }
            }
        } catch {
            print("Error encoding account to JSON: \(error)")
        }
    }
}
*/
