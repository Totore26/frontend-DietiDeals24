//
//  SellerAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol SellerAPI {
    
    func getGeneratedAuctions(accountId: String) -> [AuctionData]
    
}
