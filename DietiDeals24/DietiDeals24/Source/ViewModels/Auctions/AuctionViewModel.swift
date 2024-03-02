//
//  Auction.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//
import Foundation

struct Auction {
    var name: String
    var imageName: String
    var category: String
    var description: String
    var endTime: String
    var currentOffer: String
    var auctionType: FormattedAuctionType
    var sellerName: String
    var sellerIsYou: Bool
    var location : String
    var specifiedMinimumThreshold: String?
}

class AuctionViewModel: ObservableObject {
    // Proprietà del view model
    @Published var auction: Auction
    @Published var isFullScreen = false
    @Published var isShowedOfferSheetView = false
    @Published var offerAmount: String = ""
    @Published var raisingThreshold: Float = 10
    @Published var currentOffer: Float = 100
    
    // Inizializzatore del view model
    init() {
        self.auction = Auction(name: "Car ktm 125",
                               imageName: "png-defaultImage",
                               category: "Other",
                               description: "Lorem ipsum dolor sit amet, consectetur adipiscing capochciam efhs fdshf dsjf elit.",
                               endTime: "2d 4h 37m",
                               currentOffer: "100,00€",
                               auctionType: .fixed,
                               sellerName: "Giampiero Esposito",
                               sellerIsYou: false,
                               location : "London",
                               specifiedMinimumThreshold: "30,000.00€")
    }
    
    // Funzione per confermare un'offerta fissa
    func confirmFixedTimeOffer() {
        // Implementa qui la logica per confermare l'offerta fissa
        // Ad esempio, puoi aggiornare i dati dell'offerta nel modello o inviare una richiesta al server
        isShowedOfferSheetView = false
    }
    
    // Funzione per confermare un'offerta incrementale
    func confirmIncrementalOffer() {
        // Implementa qui la logica per confermare l'offerta incrementale
        // Ad esempio, puoi aggiornare i dati dell'offerta nel modello o inviare una richiesta al server
        isShowedOfferSheetView = false
    }
}
