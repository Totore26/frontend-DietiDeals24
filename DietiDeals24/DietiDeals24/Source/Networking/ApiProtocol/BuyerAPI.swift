//
//  BuyerAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol BuyerAPI {
    
    func getFollowedAuctions(accountId: String) -> [AuctionData]
    
}
