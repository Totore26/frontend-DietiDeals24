//
//  SellerAPI.swift
//  DietiDeals24
//
//  Created by Salvatore Tortora on 02/02/24.
//

protocol SellerAPI: AccountAPI {
    
    func getGeneratedAuctions(accountId: String) -> [Auction]
    
}
