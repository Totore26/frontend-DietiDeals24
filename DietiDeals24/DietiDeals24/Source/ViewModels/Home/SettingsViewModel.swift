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
    
    @Published var isEditProfileSheetPresented = false
    @Published var isInfoAuctionsSheetPresented = false
    @Published var isLoading = false
    @Published var isSellerSession = false // stato per la sessione del venditore
    
    init(user: AuthUser) {
        self.user = user
    }

}
