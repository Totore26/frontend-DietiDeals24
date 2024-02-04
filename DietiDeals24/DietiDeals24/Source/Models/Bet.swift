//
//  Bet.swift
//  DietiDeals24X
//
//  Created by Francesco Terrecuso on 24/01/24.
//

class Bet {
    
    var value : Float
    var buyerAssociated : Buyer
    var auctionAssociated : Auction
    
    init(value: Float, buyerAssociated: Buyer, auctionAssociated: Auction) {
        self.value = value
        self.buyerAssociated = buyerAssociated
        self.auctionAssociated = auctionAssociated
    }
    
}
