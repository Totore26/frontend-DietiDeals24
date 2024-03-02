//
//  Home.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Amplify


class HomeViewModel: ObservableObject {
    
    @Published  var searchText = ""
    @Published  var selectedPriceRange: String? = "All"
    @Published  var selectedCategory: String? = "All"
    @Published  var showCreateAuctionBanner = false
    @Published  var selectedAuctionType = FormattedAuctionType.null
    @Published  var isSeller = true
    
    let user: AuthUser
    
    init(user: AuthUser) {
        self.user = user
    }
    
    
    
    //funzione per ricercare un asta all'interno della searchView.
    func searchAuctions(category: String, princeRange: String, searchText: String) -> [Auction] {
        return []
    }
    
    

}
