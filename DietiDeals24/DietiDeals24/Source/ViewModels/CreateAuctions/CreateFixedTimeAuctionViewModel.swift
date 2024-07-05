//
//  CreateFixedTimeAuction.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import SwiftUI

class CreateFixedTimeAuctionViewModel: ObservableObject {
    
    let api = AuctionRequest()
    var id = "ID-140"
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var endOfAuction = Date()
    @Published var secretThreshold: Decimal = 0.0
    @Published var selectedCategory: String = "All"
    @Published var auctionImage: UIImage? = UIImage(systemName: "questionmark.circle")
    var user: String
    
    init(user: String) {
        self.user = user
    }
    
    func createFixedTimeAuction() {
        // Costruisci l'oggetto asta
        let auction = AuctionData(
            creator: Seller(email: user),
            participants: nil,
            title: self.title,
            description: self.description,
            imageAuction : "",
            category: self.selectedCategory,
            location: self.location,
            endOfAuction: formatEndDateForDatabase(self.endOfAuction),
            minimumSecretThreshold: self.secretThreshold
        )
        
        // Effettua la chiamata API per creare l'asta a tempo fisso utilizzando l'oggetto AuctionData
        api.createFixedTimeAuctionAPI(auction: auction) { apiSuccess, error in
            if let error = error {
                // Gestisci l'errore stampandolo
                print("Errore durante la creazione dell'asta a tempo fisso: \(error.localizedDescription)")
            } else {
                // Se non ci sono errori, mostra un messaggio di successo
                print("Asta a tempo fisso creata con successo!")
            }
        }
    }
    
    private func formatEndDateForDatabase(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Formato accettato da PostgreSQL
        return dateFormatter.string(from: date)
    }
}
