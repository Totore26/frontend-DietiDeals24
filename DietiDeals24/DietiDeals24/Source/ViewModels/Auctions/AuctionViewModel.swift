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
    
    let api = BetRequest()
    @Published var auction: AuctionData
    @Published var isFullScreen = false
    @Published var isShowedOfferSheetView = false
    @Published var offerAmount: String = ""
    
    @Published var currentOffer : Float = 0.0
    
    let user: String
    
    init(user: String,  auction: AuctionData) {
        self.user = user
        self.auction = auction
    }
    
    
    func sellerIsYou() -> Bool{
        return user == auction.creator.email
    }
    
    func isOfferValid(buyerOffer: Decimal, currentOffer : Float) -> Bool {
        let currentOfferDecimal = NSDecimalNumber(value: currentOffer).decimalValue
        return buyerOffer > currentOfferDecimal
    }
    
    func isOfferValid(buyer: Decimal) -> Bool {
        isOfferValid(buyerOffer: buyer, currentOffer: currentOffer)
    }
    
    func makeBet(finalOffer: Decimal, completion: @escaping (Bool) -> Void) {
        
        if isOfferValid(buyer: finalOffer) {
            api.betAPI(emailBuyer: user, idAuction: auction.id!, betValue: finalOffer) { success in
                completion(success)
            }
        } else {
            completion(false)
            return
        }
        
    }
    
}
