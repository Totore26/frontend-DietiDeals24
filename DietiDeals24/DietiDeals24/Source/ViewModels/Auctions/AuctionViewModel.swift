//
//  Auction.swift
//  DietiDeals24X
//
//  Created by Salvatore Tortora on 24/01/24.
//
import Foundation
import Amplify


class AuctionViewModel: ObservableObject {
    // Proprietà del view model
    @Published var auction: AuctionData
    @Published var isFullScreen = false
    @Published var isShowedOfferSheetView = false
    @Published var offerAmount: String = ""
    @Published var raisingThreshold: Float = 10
    @Published var currentOffer: Float = 100
    
    let user: String
    
    init(user: String,  auction: AuctionData) {
        self.user = user
        self.auction = auction
    }
    
    
    func sellerIsYou() -> Bool{
        return user == auction.creator.email
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
