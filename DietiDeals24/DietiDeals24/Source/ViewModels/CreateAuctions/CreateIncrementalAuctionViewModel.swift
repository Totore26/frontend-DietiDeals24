//
//  CreateIncrementalAuction.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import SwiftUI

class CreateIncrementalAuctionViewModel: ObservableObject {
    
    let api = AuctionRequest()
    var id = "ID-140"
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var startingPrice: Decimal = 0.0
    @Published var raisingThreshold: Decimal = 10.0
    @Published var timer: Int = 1
    @Published var selectedCategory: String = "All"
    @Published var auctionImage: UIImage? = nil
    var user : String
    
    init(user : String){
        self.user = user
    }
    
    
    func createIncrementalAuction(completion: @escaping (Bool, Error?) -> Void) {
        // Costruisci l'oggetto asta
        let auction = AuctionData (
            creator: Seller(email: user),
            participants: nil,
            title: self.title,
            description: self.description,
            imageAuction : "",
            category: self.selectedCategory,
            location: self.location,
            startingPrice: self.startingPrice,
            raisingThreshold: self.raisingThreshold
        )
        
        // Effettua la chiamata API per creare l'asta incrementale utilizzando l'oggetto AuctionData
        api.createIncrementalAuctionAPI(auction: auction) { apiSuccess, error in
            if let error = error {
                // Gestisci l'errore stampandolo
                print("Errore durante la creazione dell'asta incrementale: \(error.localizedDescription)")
                completion(false, error)
            } else {
                // Se non ci sono errori, restituisci il successo
                completion(apiSuccess, nil)
            }
        }
    }
    
    
    
    
    
}
