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
                    self?.selectedCategory = "All"
                    self?.selectedPriceRange = "All"
                }
            case .failure(let error):
                print("Errore nel recupero delle aste attive: \(error)")
            }
        }
    }
    
    func filterAuctions() {
        api.filterAuctions(
            searchText: searchText.isEmpty ? nil : searchText,
            category: selectedCategory == "All" ? nil : selectedCategory,
            startingPrice: selectedPriceRange == "All" ? nil : getStartingPrice(selectedPriceRange),
            endingPrice: selectedPriceRange == "All" ? nil : getEndingPrice(selectedPriceRange)
        ) { [weak self] result in
            switch result {
            case .success(let filteredAuctions):
                DispatchQueue.main.async {
                    print("ricera avvenuta con successo!")
                    self?.auctions = filteredAuctions
                }
            case .failure(let error):
                print("Errore nel filtro delle aste: \(error)")
            }
        }
    }

    private func getStartingPrice(_ priceRange: String?) -> String? {
        guard let range = priceRange else { return nil }
        
        switch range {
        case "5-10 €": return "5.0"
        case "10-20 €": return "10.0"
        case "20-50 €": return "20.0"
        case "50-100 €": return "50.0"
        case "100-250 €": return "100.0"
        case "250-500 €": return "250.0"
        case "500-1000 €": return "500.0"
        case "1000-2000 €": return "1000.0"
        case "2000+ €": return "2000.0"
        default: return nil
        }
    }

    private func getEndingPrice(_ priceRange: String?) -> String? {
        guard let range = priceRange else { return nil }
        
        switch range {
        case "5-10 €": return "10.0"
        case "10-20 €": return "20.0"
        case "20-50 €": return "50.0"
        case "50-100 €": return "100.0"
        case "100-250 €": return "250.0"
        case "250-500 €": return "500.0"
        case "500-1000 €": return "1000.0"
        case "1000-2000 €": return "2000.0"
        case "2000+ €": return nil // Non c'è un limite superiore definito
        default: return nil
        }
    }
    
    // Fa la richiesta ad S3 per scaricare tutte le foto (gli passo la lista di idAste)
    func fetchPhoto(key: String) {
        // Implementa la logica per scaricare le foto da S3
    }
    
}

