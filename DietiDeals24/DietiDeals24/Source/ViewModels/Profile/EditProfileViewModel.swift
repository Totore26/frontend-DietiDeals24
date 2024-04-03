//
//  EditProfile.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import SwiftUI

class EditProfileViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var fullName: String
    @Published var nationality: String
    @Published var description: String
    @Published var showProfileSavedBanner: Bool
    @Published var link1 : String
    @Published var link2 : String
    
    init() {
        self.profileImage = nil
        self.fullName = "Giampiero Esposito"
        self.nationality = "Italy"
        self.description = "Welcome to my profile as a passionate collector and auction participant! I'm Giampiero, a lover of art, antiques, and rarities."
        self.showProfileSavedBanner = false
        self.link1 = "facebook/account.com"
        self.link2 = "tweeter/account.com"
    }
    
    func saveProfileChanges() {
        // Implementa qui la logica per salvare le modifiche al profilo
        showProfileSavedBanner = true
    }
    
    

}
