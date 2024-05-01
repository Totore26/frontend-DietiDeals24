//
//  Setings.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Amplify

class SettingsViewModel: ObservableObject {
    
    let user: AuthUser
    let api = AccountRequest()
    
    @Published var isEditProfileSheetPresented = false
    @Published var isInfoAuctionsSheetPresented = false
    @Published var isLoading = false
    @Published var isSellerSession = false // stato per la sessione del venditore
    
    init(user: AuthUser) {
        self.user = user
    }
    
    
    func upgradeAccount(email: String) {
        isLoading = true
        
        api.upgradeAccountToSellerAPI(email: email) { success in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if success {
                    print("successo!! passato ad account Seller...\n\n")
                    self.isSellerSession = true
                } else {
                   print("errore in fase di upgrade account")
                }
            }
        }
    }

}
