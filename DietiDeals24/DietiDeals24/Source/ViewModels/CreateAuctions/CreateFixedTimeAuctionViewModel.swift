//
//  CreateFixedTimeAuction.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//

import Foundation
import SwiftUI
import Amplify

class CreateFixedTimeAuctionViewModel: ObservableObject {
    

    @Published var title: String = ""
    @Published var location: String = ""
    @Published var selectedCategory: String = "All"
    @Published var description: String = ""
    @Published var endOfAuction: Date = Date()
    @Published var secretThreshold: Float = 0.0
    @Published var auctionImage: Image? = nil
    

    
    
    // Implementa qui la logica per creare l'asta
    func createFixedTimeAuction() {}

}
