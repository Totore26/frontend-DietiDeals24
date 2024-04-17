//
//  Home.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import Amplify

class HomeViewModel: ObservableObject {
    
    let api = AuctionRequest()
    
    @Published var searchText = ""
    @Published var selectedPriceRange: String? = "All"
    @Published var selectedCategory: String? = "All"
    @Published var showCreateAuctionBanner = false
    @Published var selectedAuctionType = FormattedAuctionType.null
    @Published var isSeller = true
    @Published var auctions = [AuctionData]()
    
    let user: AuthUser
    
    init(user: AuthUser) {
        self.user = user
        getAllAuctions()
    }
    
    func getAllAuctions() {
        api.getAllActiveAuctionsAPI { result in
            switch result {
            case .success(let auctions):
                DispatchQueue.main.async { [weak self] in
                    self?.auctions = auctions
                }
                print("Aste recuperate con successo:")
                for auction in auctions {
                    print("\(auction.id ?? "N/A")")
                }
            case .failure(let error):
                print("Errore nel recupero delle aste attive: \(error)")
            }
        }
    }
    
    // Funzione per ricercare un'asta all'interno della searchView.
    func searchAuctions(category: String, princeRange: String, searchText: String) -> [AuctionData] {
        // Implementa la logica di ricerca qui
        return []
    }
    
    // Fa la richiesta ad S3 per scaricare tutte le foto (gli passo la lista di idAste)
    func fetchPhoto(key: String) {
        // Implementa la logica per scaricare le foto da S3
    }
}

